# Notifications
To use notifications with `notify-send`, you need to intsall a notification deamon.

We will use `dunst` a customizable and lightweight notification-deamon.
In order for the notifications to work, the deamon must be working. So, you need to add the `$ dunst` command to your startup window manager script.
Add this line of code to your startup screept:
```bash
dunst &
```

If you want to customize the notifications window you can add `dunstrc` file in `~/.config/dunst/` folder.

# Note

`dragon` is a binary that is installed automatically by https://github.com/mwh/dragon,
it is a drag-and-drop source/sink for X or Wayland.

