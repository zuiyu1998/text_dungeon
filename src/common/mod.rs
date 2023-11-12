use crate::states::NavigationState;
use bevy::prelude::*;

#[derive(Component)]
pub struct ChangeState(pub NavigationState);
