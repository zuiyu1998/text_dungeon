use super::{
    get_into_sequence, BattleActive, BattleEvent, BattleUnactive, CharacterProps, InCombat,
    Sequence, SequenceEntity, SequenceState,
};
use bevy::prelude::*;

//对character添加先手
pub fn add_sequenece_marker(
    mut commands: Commands,
    mut battle_ew: EventReader<BattleEvent>,
    character_q: Query<(&CharacterProps,), Without<Sequence>>,
) {
    for e in battle_ew.read() {
        for entity in e.0.iter() {
            if let Ok((props,)) = character_q.get(*entity) {
                let sequence = get_into_sequence(props.initiative_id).into_sequece(props);
                commands.entity(*entity).insert(sequence);
            }
        }
    }
}

//判定当前帧谁行动
pub fn select_charcter(
    mut commands: Commands,
    mut character_q: Query<(Entity, &mut Sequence), Without<InCombat>>,
) {
    let mut sequences = vec![];

    for (entity, sequence) in character_q.iter() {
        if sequence.state == SequenceState::None {
            sequences.push(SequenceEntity {
                entity,
                value: sequence.value,
            });
        }
    }

    if sequences.is_empty() {
        return;
    }

    sequences.sort_by(|a, b| b.value.cmp(&a.value));

    info!("{:?}", sequences);

    let (first, other) = sequences.split_first().unwrap();

    let mut sequence = character_q
        .get_component_mut::<Sequence>(first.entity)
        .unwrap();

    sequence.state = SequenceState::Active;

    commands
        .entity(first.entity)
        .insert((BattleActive, InCombat));

    for sequence in other.iter() {
        commands
            .entity(sequence.entity)
            .insert((BattleUnactive(first.entity), InCombat));
    }
}
