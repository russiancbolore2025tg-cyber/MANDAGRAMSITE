export interface FeatureItem {
  key: string;
  button: string;
  title: string;
  description: string;
  image: string;
}

export const featuresRu: FeatureItem[] = [
  {
    key: "plugins",
    button: "Плагины",
    title: "Плагины",
    description: "Плагины на C++, Rust, Zig и D. Хот-релоад прямо на лету без перезапуска клиента.",
    image: "/assets/screenshots/plugins.webp"
  },
  {
    key: "casher",
    button: "Кешер",
    title: "Кешер",
    description: "Баланс звёзд, история транзакций и донатов в одном месте.",
    image: "/assets/screenshots/casher.webp"
  },
  {
    key: "settings",
    button: "Настройки",
    title: "Настройки",
    description: "Кастомизация интерфейса, динамические темы и тонкая настройка клиента под себя.",
    image: "/assets/screenshots/settings.webp"
  },
  {
    key: "profile",
    button: "Профиль",
    title: "Профиль",
    description: "Удобный профиль с ID аккаунта в один клик, общими группами и быстрыми действиями.",
    image: "/assets/screenshots/profile.webp"
  },
  {
    key: "chats",
    button: "Чаты",
    title: "Чаты",
    description: "Кастомные папки и вкладки, нормальные закрепы и предпросмотр без лишнего мусора.",
    image: "/assets/screenshots/chats.webp"
  },
  {
    key: "proxy",
    button: "Прокси",
    title: "Прокси",
    description: "Поддержка MTProto и SOCKS5, проверка пинга и быстрое переключение серверов.",
    image: "/assets/screenshots/proxy.webp"
  }
];

export const featuresEn: FeatureItem[] = [
  {
    key: "plugins",
    button: "Plugins",
    title: "Plugins",
    description: "Native plugins in C++, Rust, Zig, and D. Hot-reload on the fly without restarting.",
    image: "/assets/screenshots/plugins.webp"
  },
  {
    key: "casher",
    button: "Cashier",
    title: "Cashier",
    description: "Telegram Stars balance, transaction history, and wallet overview in one tab.",
    image: "/assets/screenshots/casher.webp"
  },
  {
    key: "settings",
    button: "Settings",
    title: "Settings",
    description: "UI customization, dynamic palettes, and granular client controls without bloat.",
    image: "/assets/screenshots/settings.webp"
  },
  {
    key: "profile",
    button: "Profile",
    title: "Profile",
    description: "Clean user profile with one-click ID copying, mutual groups, and quick actions.",
    image: "/assets/screenshots/profile.webp"
  },
  {
    key: "chats",
    button: "Chats",
    title: "Chats",
    description: "Custom chat folders, smooth pinned messages, and clean previews.",
    image: "/assets/screenshots/chats.webp"
  },
  {
    key: "proxy",
    button: "Proxy",
    title: "Proxy",
    description: "MTProto and SOCKS5 support with live ping benchmarking and quick server switching.",
    image: "/assets/screenshots/proxy.webp"
  }
];
