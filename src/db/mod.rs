mod character_props;

use bevy::prelude::*;

pub use character_props::*;

pub struct DbPlugin;

impl Plugin for DbPlugin {
    fn build(&self, app: &mut App) {
        app.init_asset_loader::<CharacterPropValuesAssetLoader>()
            .init_asset_loader::<CharacterPropsAssetLoader>()
            .init_asset::<CharacterPropValuesAsset>()
            .init_asset::<CharacterPropsAsset>();
    }
}
