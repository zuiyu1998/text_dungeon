效果用于更改某项事物。
它提供给了一个接口给上层的单位实现。所有实现了这个接口的单位都可以使用效果来改变自身。
它提供一个接口构建效果，实现这个接口可以构建数值不同的效果。

# 效果

效果保存了要更改的所有数据。代码如下

```gds
class_name EffectContext
extends RefCounted

```

# 效果执行器

这个接口被用来执行效果。

```gds
class_name EffectExector
extends RefCounted

func apply(context: EffectContext):
	pass
```

# 效果构建器

这个接口用来构建不同的效果

```gds
class_name EffectBuilder
extends RefCounted

func build() -> EffectContext:
	return
```
