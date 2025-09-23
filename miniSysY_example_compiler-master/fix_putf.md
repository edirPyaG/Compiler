# factorial.sy putf函数输出问题修复说明

## 问题原因
编译器中 putf 函数的类型声明错误：
- 当前声明：`declare void @putf(i1*)`（i1 = 布尔类型）
- 正确声明：`declare void @putf(i8*)`（i8 = 字符类型）

## 根本原因
`src/frontend/Visitor.java` 第67行的错误：
```java
IntegerType i8Type = IntegerType.getI1(); // 错误！应该是 getI8()
```

## 修复方法

### 方法1: 修改源码重新编译
1. 修改 `src/frontend/Visitor.java` 第67行为：
   ```java
   IntegerType i8Type = IntegerType.getI8(); // 使用 i8 作为字符类型
   ```

2. 在 `src/ir/type/IntegerType.java` 中添加 i8 支持：
   ```java
   public static final IntegerType i8 = new IntegerType(8);
   public static IntegerType getI8() {return i8;}
   ```

3. 修改 toString 方法支持 i8：
   ```java
   if (this.numBits == 8) return "i8";
   ```

### 方法2: 使用修复后的编译器
由于当前项目的编译环境存在依赖问题，建议：
1. 使用正确的编译器版本
2. 或者手动替换已修复的类文件

## 验证修复
修复后，生成的 LLVM IR 应该显示：
```llvm
declare void @putf(i8*)  # 正确：i8* 而不是 i1*
```

## 为什么重启后问题暴露
- 之前可能使用了缓存的编译结果
- 或者系统环境变化导致类型不匹配问题更明显
- 内存布局变化使得空指针/错误指针的表现不同