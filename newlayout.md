
# New OS Layout

I wanted a new layout for macOS and Fedora to share the same home directory, so here I am using ZFS on Linux and ZFS on macOS side by side. 

## Experiment 1: Shared ZFS Home

I set up a very typical ZFS mount with encryption and compression, then quickly came to realise that I can't mount at different folders for each OS separately without using legacy mounts. So, I resorted to symlinks:

```
~
❯ ls -lah /home
total 12K
drwxr-xr-x.  3 root      root      4.0K Oct 30 15:59 .
dr-xr-xr-x. 21 root      root      4.0K Oct 30 16:45 ..
lrwxrwxrwx.  1 root      root        19 Oct 30 01:26 ambrose -> /dpool/home/ambrose
drwx------. 14 cooladmin cooladmin 4.0K Oct 30 02:13 cooladmin

~
❯ sudo zfs list                                                    
[sudo] password for ambrose: 
NAME                    USED  AVAIL     REFER  MOUNTPOINT
dpool                  11.7G  89.0G      520K  /dpool
dpool/home             11.7G  89.0G      456K  /dpool/home
dpool/home/ambrose     11.7G  89.0G     11.7G  /dpool/home/ambrose
tankpool               14.9G  3.50T      858K  /tankpool
[other tankpool mounts omitted]
```

This worked fine, until I realised that Fedora's tool `toolbox` doesn't deal with symlinked home directories. Instead, because it resolves the canonical folder of the home directory, it does not properly mount `/home/ambrose` into `/home/ambrose` but mounts `/dpool/home/ambrose` into `/dpool/home/ambrose`

Also, I found that Fedora Silverblue has a symlink from `/home` to `/var/home` where the actual home folder is mounted, following conventions. This is neat, I'm going to see if I can use this as a mount point. 

## Experiment 2: Moved Mountpoint to /var/home

This didn't work. I misread toolbox: it needs `/home` to be a symlink, not the user's `$HOME`. I can't do that because I want to keep a usable user in the home directory. Seems like I'd have to patch toolbox...

`.local/bin/toolbox` is my monkeypatched toolbox, just to make it work for now. I still need to figure out how to rewrite the home-link part to work with home directories like mine, without breaking everything else. The problem is toolbox currently canonicalises all homedir links but only sets up the proper links for `/var/home` links.

Funny bug, `yadm` likes to hardcode the home directory in Git. But this setup also allows me to set that hardcoded direcotry to `/var/home/ambrose`

<!-- vim: set conceallevel=2 et ts=2 sw=2: -->
