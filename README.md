# mg_mark 用来在neovim标亮多个单词

## lazy.vim

```
{
    "mongiaK/mg_mark",
}
```

## 主要方法如下

| 方法                           | 描述                     |
| ------------------------------ | ------------------------ |
| require("mg_mark").clear_all() | 清除所有标记             |
| require("mg_mark").mark()      | 标记单词（已标记则清除） |
| require("mg_mark").prev()      | 前一个单词               |
| require("mg_mark").next()      | 后一个单词               |
