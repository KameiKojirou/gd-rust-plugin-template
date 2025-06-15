# Rust + Godot 4.4.1 Android Plugin (gdextension) Guide for LINUX/UBUNTU HOST

A concise recipe for cross-compiling a Rust `cdylib` for Android (arm64-v8a) and wiring it up in your `.gdextension`.

---

## 1. Prerequisites

- Android SDK + NDK (we use NDK **r23.2.8568313** here)  
- Rust + `rustup`  
- Godot 4.4.1 with `gdextension` support  
- (Optional) `cargo-ndk` for multi-ABI builds

---

## 2. Environment Setup

```bash
# 2.1. Point at your NDK & choose API level
export ANDROID_NDK_HOME="$HOME/Android/Sdk/ndk/23.2.8568313"
export API_LEVEL=21

# 2.2. LLVM toolchain bin directory
TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin"

# 2.3. Tell Cargo which linker + ar to use
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=\
"$TOOLCHAIN/aarch64-linux-android${API_LEVEL}-clang"
export CARGO_TARGET_AARCH64_LINUX_ANDROID_AR="$TOOLCHAIN/llvm-ar"

# 2.4. (Optional) If you use C++ in your crate
export CARGO_TARGET_AARCH64_LINUX_ANDROID_CXX=\
"$TOOLCHAIN/aarch64-linux-android${API_LEVEL}-clang++"

# 2.5. Verify the tools exist
ls -l \
  "$CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER" \
  "$CARGO_TARGET_AARCH64_LINUX_ANDROID_AR"
```

---

## 3. Build the Rust `cdylib`

From your plugin root (where `Cargo.toml` lives):

```bash
# Debug build
cargo build --target aarch64-linux-android

# Release build
cargo build --release --target aarch64-linux-android
```

Binaries will be in:

- `target/aarch64-linux-android/debug/libexample_rust_plugin.so`  
- `target/aarch64-linux-android/release/libexample_rust_plugin.so`

---

## 4. `.gdextension` Configuration

Edit `res://addons/example_rust_plugin/example_rust_plugin.gdextension`:

```ini
[configuration]
entry_symbol = "gdext_rust_init"
compatibility_minimum = 4.1
reloadable = true

[libraries]
# Desktop targets (unchanged) …
linux.debug.x86_64     = "res://addons/example_rust_plugin/\
target/release/libexample_rust_plugin.so"
linux.release.x86_64   = "res://addons/example