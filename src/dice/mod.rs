use rand::{thread_rng, Rng};

#[derive(PartialEq, Eq, Clone, Copy)]
pub enum DiceTrend {
    Advantage,
    Disadvantage,
    Normal,
}

pub struct Dice {
    pub max_range: i32,
    pub trend: DiceTrend,
}

pub struct DiceResult {
    pub real: i32,
    pub first: i32,
    pub two: Option<i32>,
}

impl Dice {
    pub fn new(max_range: i32, trend: DiceTrend) -> Self {
        Dice { max_range, trend }
    }

    pub fn get_numer(&self) -> DiceResult {
        let mut rng = thread_rng();

        let first = rng.gen_range(0..self.max_range) + 1;

        if self.trend == DiceTrend::Normal {
            return DiceResult {
                first,
                real: first,
                two: None,
            };
        }

        let two = rng.gen_range(0..self.max_range) + 1;

        if self.trend == DiceTrend::Disadvantage {
            return DiceResult {
                first,
                real: first.min(two),
                two: Some(two),
            };
        } else {
            return DiceResult {
                first,
                real: first.max(two),
                two: Some(two),
            };
        }
    }
}

impl Default for Dice {
    fn default() -> Self {
        Dice {
            max_range: 20,
            trend: DiceTrend::Normal,
        }
    }
}
