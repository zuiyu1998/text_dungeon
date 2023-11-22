use crate::states::NavigationState;
use bevy::prelude::*;

mod player;

pub use player::*;

#[derive(Component)]
pub struct ChangeState(pub NavigationState);
