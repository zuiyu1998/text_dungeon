use bevy::asset::AsyncReadExt;
use bevy::utils::thiserror::{self, Error};
use bevy::{
    asset::{io::Reader, AssetLoader, LoadContext},
    prelude::*,
    reflect::TypePath,
    utils::BoxedFuture,
};

#[derive(Debug, Error)]
pub enum CSVAssetLoaderError {
    #[error("Could not load file: {0}")]
    Io(#[from] std::io::Error),
    #[error("{0}")]
    Csv(#[from] csv::Error),
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

                let prop_enum = record.get(1).unwrap().to_string();
                let max = record.get(2).unwrap().parse::<f32>().unwrap();
                let value = record.get(1).unwrap().parse::<f32>().unwrap();

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
        &["character_props.csv"]
    }
}

#[derive(Asset, TypePath, Debug)]
pub struct CharacterPropValuesAsset(Vec<PropValueModel>);

#[derive(Debug)]
pub struct PropValueModel {
    prop_enum: String,
    max: f32,
    value: f32,
}
