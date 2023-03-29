FROM archlinux:base-devel

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm bc cpio kmod libelf perl tar xz pahole clang sudo git

RUN useradd -g wheel --create-home wulan17

COPY 0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch cachy5.8.pick.patch choose-gcc-optimization.sh PKGBUILD .SRCINFO /home/wulan17/

RUN mkdir /home/wulan17/share

RUN chown -R wulan17 /home/wulan17

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
