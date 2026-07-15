# Keyboard device IDs

Reference for the external keyboards mapped in `karabiner.json`. Karabiner
targets devices by `vendor_id` + `product_id`, so keep this list in sync as
you add keyboards. IDs are consistent across machines for the same
model/connection type, so they're portable.

## How to find IDs

Open **Karabiner-EventViewer → Devices** tab and read the vendor/product IDs
for the plugged-in keyboard. Don't guess. Note that Bluetooth vs USB can
report different IDs for the same keyboard.

## Known keyboards

| Keyboard                | Layout       | Connection      | vendor_id | product_id |
|-------------------------|--------------|-----------------|-----------|------------|
| Vortex Tab 90M ISO      | UK / ISO     | USB             | 1241      | 838        |
| Dell Universal Receiver | UK / ISO     | USB (wireless)  | 16700     | 17667      |

## Reloading the config

Karabiner normally picks up edits to `karabiner.json` live. But because this
file is a **symlink** into the dotfiles repo, Karabiner doesn't always notice
changes written through it. If an edit doesn't take effect, restart the
Karabiner server:

```sh
launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.karabiner_console_user_server
```

## Adding a new keyboard

- **simple_modifications**: add a new entry to the `devices[]` array with the
  new keyboard's vendor/product IDs.
- **complex_modifications**: add the new keyboard's IDs to the `identifiers[]`
  array inside each `device_if` condition — rules then fire for either device.
  Only duplicate a rule if the two keyboards need different mappings.
- Add a row to the table above so the mapping stays documented.
