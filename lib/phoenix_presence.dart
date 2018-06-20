import 'dart:convert';

typedef Map PhoenixChooserFunc(String device, Map presence);
typedef void PhoenixPresenceCallback(
    String key, Map oldPresence, Map newPresence);

class PhoenixPresence {
  static Map syncState(Map currentState, Map newState,
      [PhoenixPresenceCallback onJoin, PhoenixPresenceCallback onLeave]) {
    var state = _clone(currentState);
    var joins = {};
    var leaves = {};

    state.forEach((key, presence) {
      if (newState[key] == null) {
        leaves[key] = presence;
      }
    });

    newState.forEach((key, newPresence) {
      var currentPresence = state[key];
      if (currentPresence != null) {
        var newRefs = newPresence['metas'].map((m) => m['phx_ref']).toSet();
        var curRefs = currentPresence['metas'].map((m) => m['phx_ref']).toSet();
        var joinedMetas =
            newPresence['metas'].where((m) => !curRefs.contains(m['phx_ref']));
        var leftMetas = currentPresence['metas']
            .where((m) => !newRefs.contains(m['phx_ref']));
        if (joinedMetas.length > 0) {
          joins[key] = newPresence;
          joins[key]['metas'] = joinedMetas.toList();
        }
        if (leftMetas.length > 0) {
          leaves[key] = _clone(currentPresence);
          leaves[key]['metas'] = leftMetas.toList();
        }
      } else {
        joins[key] = newPresence;
      }
    });

    return syncDiff(state, {'joins': joins, 'leaves': leaves}, onJoin, onLeave);
  }

  static Map syncDiff(Map currentState, Map newState,
      [PhoenixPresenceCallback onJoin, PhoenixPresenceCallback onLeave]) {
    var joins = newState['joins'];
    var leaves = newState['leaves'];
    var state = _clone(currentState);

    joins.forEach((key, newPresence) {
      var currentPresence = state[key];
      state[key] = newPresence;
      if (currentPresence != null) {
        currentPresence['metas']
            .forEach((m) => state[key]['metas'].insert(0, m));
      }
      if (onJoin != null) {
        onJoin(key, currentPresence, newPresence);
      }
    });

    leaves.forEach((key, leftPresence) {
      var currentPresence = state[key];
      if (currentPresence == null) {
        return;
      }
      var refsToRemove = leftPresence['metas'].map((m) => m['phx_ref']).toSet();
      currentPresence['metas'] = currentPresence['metas']
          .where((p) => !refsToRemove.contains(p['phx_ref']))
          .toList();
      if (onLeave != null) {
        onLeave(key, currentPresence, leftPresence);
      }
      if (currentPresence['metas'].length == 0) {
        state.remove(key);
      }
    });

    return state;
  }

  static List list(Map presences, [PhoenixChooserFunc chooser]) {
    chooser ??= (String key, Map presence) => {key: presence};

    var out = [];
    presences.forEach((key, presence) => out.add(chooser(key, presence)));
    return out;
  }

  static _clone(object) => json.decode(json.encode(object));
}
