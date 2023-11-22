use bevy::{prelude::*, utils::HashMap};

///属性key
#[derive(Clone, Hash, PartialEq, Eq)]
pub enum PropKey {
    //力量
    Power,
}

pub struct PropValue {}

pub struct PropValues(HashMap<PropKey, PropValue>);

impl PropValues {
    pub fn update_value(&mut self, key: PropKey, value: PropValue) -> Option<PropValue> {
        self.0.insert(key, value)
    }
}

///属性
#[derive(Component)]
pub struct Props {
    buffs: HashMap<i32, BoxedBuf>,
    values: PropValues,
}

impl Props {
    pub fn update_value(&mut self, key: PropKey, value: PropValue) -> Option<PropValue> {
        self.values.update_value(key, value)
    }

    pub fn add_buff(&mut self, buff: impl Buff) {
        let buff: BoxedBuf = Box::new(buff);

        if !self.buffs.contains_key(&buff.id()) {
            info!("add buff, buff id : {}", buff.id());

            buff.on_add(&mut self.values);
            self.buffs.insert(buff.id(), buff);
        }
    }

    pub fn remove_buff(&mut self, buff_id: i32) -> Option<BoxedBuf> {
        if let Some(buff) = self.buffs.remove(&buff_id) {
            info!("remove buff, buff id : {}", buff.id());

            buff.on_remove(&mut self.values);
            Some(buff)
        } else {
            None
        }
    }
}

pub trait Buff: Sync + Send + 'static {
    fn id(&self) -> i32;
    fn on_add(&self, values: &mut PropValues);
    fn on_remove(&self, values: &mut PropValues);
}

pub type BoxedBuf = Box<dyn Buff>;
