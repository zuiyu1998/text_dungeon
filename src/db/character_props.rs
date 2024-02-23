use bevy::asset::AsyncReadExt;
use bevy::ecs::system::SystemParam;
use bevy::utils::thiserror::{self, Error};
use bevy::utils::HashMap;
use bevy::{
    asset::{io::Reader, AssetLoader, LoadContext},
    prelude::*,
    reflect::TypePath,
    utils::BoxedFuture,
};

use bevy_asset_loader::prelude::*;

#[derive(SystemParam)]
pub struct CharacterPropsDb<'w> {
    character_props_assets: Res<'w, CharacterPropsAssets>,
    character_props_assets_storage: Res<'w, Assets<CharacterPropsAsset>>,
    character_prop_values_assets_storage: Res<'w, Assets<CharacterPropValuesAsset>>,
}

impl<'w> CharacterPropsDb<'w> {
    pub fn get_id(&self, id: usize) -> (&CharacterPropsModel, &CharacterPropValuesAsset) {
        let character_props_model = self
            .character_props_assets_storage
            .get(self.character_props_assets.default.clone())
            .unwrap()
            .get(&id)
            .unwrap();

        let props_value_asset = self
            .character_prop_values_assets_storage
            .get(character_props_model.prop_values_asset_handle.clone())
            .unwrap();

        (character_props_model, props_value_asset)
    }
}

#[derive(AssetCollection, Resource)]
pub struct CharacterPropsAssets {
    #[asset(path = "character/props/default.character_props_asset.csv")]
    pub default: Handle<CharacterPropsAsset>,
}

#[derive(Debug, Error)]
pub enum CSVAssetLoaderError {
    #[error("Could not load file: {0}")]
    Io(#[from] std::io::Error),
    #[error("{0}")]
    Csv(#[from] csv::Error),
}

#[derive(Default)]
pub struct CharacterPropsAssetLoader;

impl AssetLoader for CharacterPropsAssetLoader {
    type Asset = CharacterPropsAsset;
    type Settings = ();
    type Error = CSVAssetLoaderError;

    fn load<'a>(
        &'a self,
        reader: &'a mut Reader,
        _settings: &'a (),
        load_context: &'a mut LoadContext,
    ) -> BoxedFuture<'a, Result<Self::Asset, Self::Error>> {
        Box::pin(async move {
            info!("Loading CharacterProp...");

            let mut bytes = Vec::new();
            reader.read_to_end(&mut bytes).await?;
            let mut rdr = csv::ReaderBuilder::new()
                .has_headers(true)
                .delimiter(b',')
                .from_reader(bytes.as_slice());

            let mut models = HashMap::default();

            for record in rdr.records() {
                let record = record?;

                let id = record.get(0).unwrap().parse::<usize>().unwrap();
                let initiative_id = record.get(1).unwrap().parse::<usize>().unwrap();
                let prop_values_asset_name = record.get(2).unwrap().to_string();

                let prop_values_asset_path = load_context.path().parent().unwrap().join(format!(
                    "{}.character_prop_values_asset.csv",
                    prop_values_asset_name
                ));

                let prop_values_asset_handle = load_context.load(prop_values_asset_path);

                let model = CharacterPropsModel {
                    id,
                    initiative_id,
                    prop_values_asset_handle,
                };

                models.insert(id, model);
            }

            Ok(CharacterPropsAsset(models))
        })
    }

    fn extensions(&self) -> &[&str] {
        &["character_props_asset.csv"]
    }
}

#[derive(Asset, TypePath, Debug, Deref)]
pub struct CharacterPropsAsset(HashMap<usize, CharacterPropsModel>);

#[derive(Debug)]
pub struct CharacterPropsModel {
    pub id: usize,
    pub initiative_id: usize,
    pub prop_values_asset_handle: Handle<CharacterPropValuesAsset>,
}

#[derive(Default)]
pub struct CharacterPropValuesAssetLoader;

impl AssetLoader for CharacterPropValuesAssetLoader {
    type Asset = CharacterPropValuesAsset;
    type Settings = ();
    type Error = CSVAssetLoaderError;

    fn load<'a>(
        &'a self,
        reader: &'a mut Reader,
        _settings: &'a (),
        _load_context: &'a mut LoadContext,
    ) -> BoxedFuture<'a, Result<Self::Asset, Self::Error>> {
        Box::pin(async move {
            info!("Loading CharacterPropValues...");

            let mut bytes = Vec::new();
            reader.read_to_end(&mut bytes).await?;
            let mut rdr = csv::ReaderBuilder::new()
                .has_headers(true)
                .delimiter(b',')
                .from_reader(bytes.as_slice());

            let mut models = vec![];

            for record in rdr.records() {
                let record = record?;

                let prop_enum = record.get(0).unwrap().to_string();
                let max = record.get(1).unwrap().parse::<f32>().unwrap();
                let value = record.get(2).unwrap().parse::<f32>().unwrap();

                let prop_value_model = PropValueModel {
                    prop_enum,
                    max,
                    value,
                };

                models.push(prop_value_model);
            }

            Ok(CharacterPropValuesAsset(models))
        })
    }

    fn extensions(&self) -> &[&str] {
        &["character_prop_values_asset.csv"]
    }
}

#[derive(Asset, TypePath, Debug)]
pub struct CharacterPropValuesAsset(pub Vec<PropValueModel>);

#[derive(Debug)]
pub struct PropValueModel {
    pub prop_enum: String,
    pub max: f32,
    pub value: f32,
}
