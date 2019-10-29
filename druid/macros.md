# Macro

## PVE

### Heal parties

#### 队友1-3
```text
#showtooltip
/cancelform
/cast [nomod] 回春术
/cast [mod:shift, @party1] 回春术
/cast [mod:alt, @party2] 回春术
/cast [mod:ctrl, @party3] 回春术
```

```text
#showtooltip
/cancelform
/cast [nomod] 治疗之触
/cast [mod:shift, @party1] 治疗之触
/cast [mod:alt, @party2] 治疗之触
/cast [mod:ctrl, @party3] 治疗之触
```

```text
#showtooltip
/cancelform
/cast [nomod] 驱毒术
/cast [mod:shift, @party1] 驱毒术
/cast [mod:alt, @party2] 驱毒术
/cast [mod:ctrl, @party3] 驱毒术
```

```text
#showtooltip
/cancelform
/cast [nomod] 愈合
/cast [mod:shift, @party1] 愈合
/cast [mod:alt, @party2] 愈合
/cast [mod:ctrl, @party3] 愈合
```

```text
#showtooltip
/cancelform
/cast [nomod] 解除诅咒
/cast [mod:shift, @party1] 解除诅咒
/cast [mod:alt, @party2] 解除诅咒
/cast [mod:ctrl, @party3] 解除诅咒
```

#### 队友4

> 只有3个Modify组合按键用来指定小队的3个成员,第4个成员只能把常用的技能绑定到按键

```text
#showtooltip
/cancelform
/cast [@party4] 回春术
```

```text
#showtooltip
/cancelform
/cast [@party4] 治疗之触
```

```text
#showtooltip
/cancelform
/cast [@party4] 驱毒术
```

```text
#showtooltip
/cancelform
/cast [@party4] 愈合
```

```text
#showtooltip
/cancelform
/cast [@party4] 解除诅咒
```

## 杂项

### 搜索标记附近名称
```text
/cleartarget
/tar [nodead] 高地
/run SetRaidTarget("target",8)
```
