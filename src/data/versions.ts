export interface VersionChange {
  text: string;
  type?: 'add' | 'fix' | 'warn' | 'tools' | 'pencil';
  warn?: boolean;
}

export interface VersionItem {
  version: string;
  base: string;
  date: string;
  changes: VersionChange[];
}

export const versionsRu: VersionItem[] = [
  {
    version: "v1.0.0",
    base: "MandaGram.exe · C ABI",
    date: "11 октября 2026",
    changes: [
      { text: "Добавлена система плагинов (нативная C ABI архитектура для C++, Rust, Zig, D).", type: "add" },
      { text: "Настройки приватности, уведомлений и срока неактивности синхронизируются с Telegram.", type: "add" },
      { text: "Добавлен код-пароль с автоблокировкой (AppLock).", type: "add" },
      { text: "Подключены автозагрузка, автовоспроизведение и энергосбережение.", type: "tools" },
      { text: "Добавлены закрепление и скрытие подарков, воспроизведение музыки профиля.", type: "add" }
    ]
  },
  {
    version: "v0.8.0",
    base: "MandaGram-1.0.0-linux-x86_64.AppImage + Win",
    date: "9 октября 2026",
    changes: [
      { text: "Добавлены профили групп и каналов с участниками и общими медиа.", type: "add" },
      { text: "Исправлено отображение окна при переносе между мониторами с разным масштабом.", type: "fix" },
      { text: "Ответы на недоступные сообщения больше не мешают загрузке переписки.", type: "fix" },
      { text: "Исправлена подгрузка премиум-эмодзи и сброс их состояния при смене аккаунта.", type: "fix" },
      { text: "Улучшена загрузка медиа, исправлены отмена и повторная загрузка.", type: "fix" },
      { text: "Снижена нагрузка от анимаций, исправлены вылеты при очистке кеша.", type: "tools" },
      { text: "Улучшена загрузка шрифтов и отображение кириллицы.", type: "pencil" },
      { text: "Добавлен локальный журнал ошибок без автоматической отправки данных.", type: "add" },
      { text: "Оптимизация и адаптация сборки под Linux x86_64 AppImage.", type: "tools" }
    ]
  },
  {
    version: "v0.7.2",
    base: "MandaGram.exe",
    date: "8 октября 2026",
    changes: [
      { text: "Исправлены статусы пользователей в профиле.", type: "fix" },
      { text: "Каналы сохраняют позицию просмотра; сообщения отмечаются прочитанными только после подтверждения сервера.", type: "tools" },
      { text: "Исправлена анонимность подарков и переходы к профилям отправителя и получателя.", type: "fix" },
      { text: "Ссылки и упоминания в описании профиля теперь открываются корректно.", type: "fix" },
      { text: "Обычный эмодзи-статус открывает свой набор.", type: "add" },
      { text: "Добавлены первые буквы названий стандартных топиков.", type: "add" },
      { text: "Убрано дублирование названия MandaGram в списке устройств.", type: "fix" }
    ]
  },
  {
    version: "v0.7.0",
    base: "MandaGram.exe + AppImage",
    date: "5–6 октября 2026",
    changes: [
      { text: "Добавлена поддержка групп с топиками и отображение файлов.", type: "add" },
      { text: "Ctrl+V и новый диалог отправки медиа, адаптивный просмотр историй.", type: "add" },
      { text: "Горячие клавиши для навигации, управления окном и действий с сообщениями.", type: "tools" },
      { text: "Форматирование текста, ответы, редактирование и пересылка с клавиатуры.", type: "tools" },
      { text: "Поиск по теме, чату или всем перепискам с подсветкой совпадений и переходом.", type: "add" }
    ]
  },
  {
    version: "v0.6.2",
    base: "Билд 0.6.2",
    date: "4 октября 2026",
    changes: [
      { text: "Устранены утечки памяти до 3 ГБ при загрузке стикеров и премиум-эмодзи.", type: "fix" },
      { text: "Исправлены медиа, которые иногда не прогружались дальше превью.", type: "fix" },
      { text: "Белая иконка на весь экран и корректное масштабирование при перетаскивании.", type: "fix" },
      { text: "Поддержка Windows Snap Layouts при наведении курсора на кнопку «Развернуть».", type: "add" },
      { text: "Компактное трей-меню с плавными анимациями по стандартам Windows.", type: "tools" },
      { text: "Исправлен спойлер: накладывается на весь текст, а не только на последнюю строку.", type: "fix" },
      { text: "Добавлена возможность изменять ширину левой вкладки с чатами и папками.", type: "add" }
    ]
  },
  {
    version: "v0.6.1",
    base: "Билд 0.6.1",
    date: "3 октября 2026",
    changes: [
      { text: "Подредактирован масштаб узора в ячейках NFT подарков.", type: "pencil" },
      { text: "Сделано плавное выделение чатов в списке чатов.", type: "add" },
      { text: "Создан каркас для плавных анимаций переходов из чата в чат.", type: "add" },
      { text: "Затянут пояс клиенту: строгое ограничение потребления памяти, больше не жрет под 2 ГБ.", type: "tools" }
    ]
  },
  {
    version: "v0.6.0",
    base: "Билд 0.6",
    date: "2–3 октября 2026",
    changes: [
      { text: "Статус прочитанности и чтение видимых на экране сообщений.", type: "add" },
      { text: "Скрытие и спойлеры в списке чатов со скругленной закраской текста.", type: "add" },
      { text: "Исправление вечного статуса «В сети» и корректное удаление сообщений.", type: "fix" },
      { text: "Быстрый выход из чата по клавише ESC и скролл вверх при клике на папку / «Все».", type: "tools" },
      { text: "Контекстное меню в системном трее при закрытом окне.", type: "add" },
      { text: "Сегментированный закрепленный баннер и расширенный фейд сообщений.", type: "add" },
      { text: "Отображение NFT юзернеймов и кнопка «Перейти на фрагмент» для чужих подарков.", type: "add" },
      { text: "В группах отображение реакций не числами, а аватарками участников.", type: "add" },
      { text: "Отображение дня недели для сообщений старше 24 часов и полной даты.", type: "tools" },
      { text: "Port exteraGram pattern constellation, adaptive tint и фикс NFT grid cells (Commits 891d51e, b5f740c).", type: "pencil" }
    ]
  }
];

export const versionsEn: VersionItem[] = [
  {
    version: "v1.0.0",
    base: "MandaGram.exe · C ABI",
    date: "October 11, 2026",
    changes: [
      { text: "Added native C ABI plugin system (C++, Rust, Zig, D).", type: "add" },
      { text: "Synced privacy, notifications, and account self-destruct with Telegram cloud.", type: "add" },
      { text: "Added AppLock passcode with auto-lock timer.", type: "add" },
      { text: "Connected auto-download, auto-play, and power-saving modes.", type: "tools" },
      { text: "Added gift pin/hide controls and profile music playback.", type: "add" }
    ]
  },
  {
    version: "v0.8.0",
    base: "MandaGram-1.0.0-linux-x86_64.AppImage + Win",
    date: "October 9, 2026",
    changes: [
      { text: "Added group and channel profiles with members and shared media.", type: "add" },
      { text: "Fixed window layout when dragging across monitors with different DPI scales.", type: "fix" },
      { text: "Replies to inaccessible messages no longer block chat loading.", type: "fix" },
      { text: "Fixed premium emoji fetching and state resets on account change.", type: "fix" },
      { text: "Improved media downloads, download cancel and retry logic.", type: "fix" },
      { text: "Reduced animation CPU load and eliminated cache clearing crashes.", type: "tools" },
      { text: "Improved font loading and Cyrillic glyph rendering.", type: "pencil" },
      { text: "Added local crash/error log without telemetry transmissions.", type: "add" },
      { text: "Full adaptation and optimization for Linux x86_64 AppImage build.", type: "tools" }
    ]
  },
  {
    version: "v0.7.2",
    base: "MandaGram.exe",
    date: "October 8, 2026",
    changes: [
      { text: "Fixed user presence status in profile header.", type: "fix" },
      { text: "Channels preserve scroll position; read marks sent only after server confirmation.", type: "tools" },
      { text: "Fixed gift anonymity flags and navigation to sender/receiver profiles.", type: "fix" },
      { text: "Links and mentions in profile bio now open correctly.", type: "fix" },
      { text: "Clicking standard emoji statuses opens its emoji pack.", type: "add" },
      { text: "Added initial letters for default forum topic badges.", type: "add" },
      { text: "Removed duplicate MandaGram entries in active sessions list.", type: "fix" }
    ]
  },
  {
    version: "v0.7.0",
    base: "MandaGram.exe + AppImage",
    date: "October 5–6, 2026",
    changes: [
      { text: "Topic groups support, file view, and stability fixes.", type: "add" },
      { text: "Ctrl+V fast media upload dialog and adaptive stories viewer.", type: "add" },
      { text: "Hotkeys for keyboard navigation, window management, and message actions.", type: "tools" },
      { text: "Text formatting, keyboard replies, inline editing, and keyboard forwarding.", type: "tools" },
      { text: "Search across topics, active chat, or all dialogs with match highlights.", type: "add" }
    ]
  },
  {
    version: "v0.6.2",
    base: "Build 0.6.2",
    date: "October 4, 2026",
    changes: [
      { text: "Eliminated memory leaks up to 3 GB caused by animated stickers and premium emojis.", type: "fix" },
      { text: "Fixed media downloads that stalled on thumbnail preview.", type: "fix" },
      { text: "White full-screen icon and seamless full-screen drag scaling.", type: "fix" },
      { text: "Windows Snap Layouts support when hovering over the maximize button.", type: "add" },
      { text: "Compact tray context menu with smooth animations according to Windows standards.", type: "tools" },
      { text: "Fixed spoiler mask: now covers entire multi-line text instead of only the last line.", type: "fix" },
      { text: "Added resizable left chatlist and folder sidebar panel.", type: "add" }
    ]
  },
  {
    version: "v0.6.1",
    base: "Build 0.6.1",
    date: "October 3, 2026",
    changes: [
      { text: "Refined constellation pattern scale inside NFT gift cells.", type: "pencil" },
      { text: "Added smooth chat item hover and selection in chatlist.", type: "add" },
      { text: "Scaffolded smooth transition animations between chats.", type: "add" },
      { text: "Tightened memory limits: client memory stays strictly capped below 2 GB.", type: "tools" }
    ]
  },
  {
    version: "v0.6.0",
    base: "Build 0.6",
    date: "October 2–3, 2026",
    changes: [
      { text: "Read receipt indicators and visible-on-screen message marking.", type: "add" },
      { text: "Chatlist preview spoilers with rounded text highlights.", type: "add" },
      { text: "Fixed persistent online status and corrected message deletion.", type: "fix" },
      { text: "Instant chat exit via ESC key and scroll-to-top on folder / All tab click.", type: "tools" },
      { text: "System tray context menu accessible when window is closed.", type: "add" },
      { text: "Segmented pinned message banner with extended timeline fade.", type: "add" },
      { text: "NFT usernames display and direct 'Go to Fragment' button on gifts.", type: "add" },
      { text: "Group reactions display member avatars instead of raw count numbers.", type: "add" },
      { text: "Weekday timestamps for messages older than 24h; full date if older than a week.", type: "tools" },
      { text: "Ported exteraGram pattern constellation, adaptive tint, and NFT grid cells (Commits 891d51e, b5f740c).", type: "pencil" }
    ]
  }
];
