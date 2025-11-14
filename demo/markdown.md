---
author: "yuchenfei"
description: "Based on OXY2DEV"
---

# Markdown Demo

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

# Setext 1

## Setext 2

## Code block

```c Info string
printf("Hello world!")
```

```html A very long info string that will not fit here! And to be absolutely sure I will add a few more words.
<p>Hello world!</p>
```

```sh
ls -la
```

```js
console.log("Hello world!");
```

```lua
vim.print("Hello world!");
```

```markdown
Hello _world!_
```

```py
print("Hello world!");
```

```ts
console.log("Hello world!");
```

```typst
Hello _world!_
```

## Dashed line

---

## List bullets

- Nest 0 Item 1
  - Nest 1 Item 1
  - Nest 1 Item 2
    - Nest 2 Item 1
      - Nest 3 Item 1
        - Nest 4 Item 1
- Nest 0 Item 2
  - Nest 1 Item 3

1. Order 1
2. Order 2
   a. Order 1.1
   b. Test

## Check boxes

- [ ] Unchecked
- [x] Checked
- [-] Todo
- [~] Canceled
- [>] Favorited
- [!] Important
- [?] Question

- [ ] Switch Test

1. [ ] Switch Test

- [ ] test
  - [ ] test 1
  - [ ] test 2

## Block quotes

> A regular block quote.
> It spans across multiple lines.
>
> It also contains an empty line.

; Long block quotes

> Just a long line
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ut eleifend metus. Proin velit dui, suscipit in viverra eu, scelerisque dictum elit.

## Tables

| Normal     | Left                 |               Center                |         Right |
| ---------- | :------------------- | :---------------------------------: | ------------: |
| 1          | 2                    |                  3                  |             4 |
| **Bold**   | _italic_             |          **_Bold italic_**          | `Inline code` |
| [Shortcut] | [Reddit](reddit.com) | ![Image](./attachments/hamster.jpg) | [[README]] |

## Callouts

; Github

> [!NOTE]

> [!TIP]

> [!IMPORTANT]

> [!WARNING]

> [!CAUTION]

; Obsidian

> [!ABSTRACT]

> [!SUMMARY]

> [!TLDR]

> [!INFO]

> [!TODO]

> [!HINT]

> [!SUCCESS]

> [!CHECK]

> [!DONE]

> [!QUESTION]

> [!HELP]

> [!FAQ]

> [!ATTENTION]

> [!FAILURE]

> [!FAIL]

> [!MISSING]

> [!DANGER]

> [!ERROR]

> [!BUG]

> [!EXAMPLE]

> [!QUOTE]

> [!CITE]

> [!WIP]

> [!FAIL] Switch Test (TODO, WIP, DONE, FAIL)

; Nested callouts

> [!ABSTRACT]
>
> > [!SUCCESS] Custom title
> >
> > > [!QUESTION]
> > >
> > > > [!FAILURE] Custom title

## Links

- ![Image](test.png)
- [Markdown File](README.md)
- [Python File](test.py)
- [Website](https://test.com)
- [[README]]
- [[README|Wikilink Alias]]
- [Reference][Test]
- <user@test.com>

## Reference definitions

[Test]: www.neovim.org
