<div align="center">
  <h1><b>BufferUtil</b></h1>
  <p>Serialization library.</p>
</div>

**BufferUtil** is <ins>fast and cheap</ins> serialization library for completely different tasks, be it one-time or continuous data serialization.

Inspired by [BufferUtil by Sleitnick](https://github.com/Sleitnick/RbxUtil/tree/main/modules/buffer-util) and [Sera](https://github.com/MadStudioRoblox/Sera).

## Benchmark
All benchmarks were performed using [Scriptbench](https://devforum.roblox.com/t/scriptbench-v300-free-open-source-heavy-duty-graphing-benchmarker/3815286), and the benchmark code is located in the <a href="Benchmark">Benchmark</a> folder.

1. Download latest rbxm file from [Releases](https://github.com/onedps/BufferUtil/releases/latest). After downloading throw rbxm file into Roblox Studio and it will appear in the workspace.

2. Add [library](https://create.roblox.com/store/asset/126064419280191/BufferUtil) from creator store. (Currently unavailable)

---

## Setup
There are 2 options for installing BufferUtil.

1. Download latest rbxm file from [Releases](https://github.com/onedps/BufferUtil/releases/latest). After downloading throw rbxm file into Roblox Studio and it will appear in the workspace.

2. Add [library](https://create.roblox.com/store/asset/126064419280191/BufferUtil) from creator store. (Currently unavailable)

---

## API Reference

### `.Write(buf: buffer, offset: number, value: Type): buffer`

`.Write` is a function that every added/existing type must have.

`.Write` writes the `value` to `buf` at `offset`, and returns `buf` (If the `buf` is nil, it will be created)

```luau
local write = BufferUtil.Float.Write(nil, 0, 100)
```

---

### `.Read(buf: buffer, offset: number): Type`

`.Read` reads and returns the value that you `.Write`, from the `buf` at `offset`.

```luau
local read = BufferUtil.Float.Read(write, 0)
```

---

**BufferUtil** is released under the <a href="LICENSE">MIT License</a>.