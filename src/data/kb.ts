export interface KbHeading {
  level: number;
  id: string;
  text: string;
}

export interface KbArticle {
  slug: string;
  title: string;
  category: string;
  readingTime: string;
  sectionsCount: string;
  prev?: { slug: string; title: string } | null;
  next?: { slug: string; title: string } | null;
  headings: KbHeading[];
  content: string;
}

export interface KbCategory {
  title: string;
  description: string;
  articles: Array<{
    slug: string;
    title: string;
    readTime: string;
  }>;
}

export const kbCategories: KbCategory[] = [
  {
    title: "Начало работы",
    description: "Установка, базовые принципы и настройка клиента MandaGram",
    articles: [
      { slug: "intro", title: "Введение в MandaGram", readTime: "3 мин" },
      { slug: "installation", title: "Установка на Windows и Linux", readTime: "4 мин" },
      { slug: "hotkeys", title: "Горячие клавиши и шорткаты", readTime: "3 мин" }
    ]
  },
  {
    title: "Разработка плагинов",
    description: "Нативный C ABI, перехват хуков, горячая замена и сборка на разных языках",
    articles: [
      { slug: "quickstart", title: "Быстрый старт: первый плагин", readTime: "5 мин" },
      { slug: "api", title: "C API и перехват методов", readTime: "6 мин" },
      { slug: "examples", title: "Примеры на C++, Rust, Zig и D", readTime: "7 мин" },
      { slug: "hotreload", title: "Горячая перезагрузка (Hot-Reload)", readTime: "4 мин" },
      { slug: "storage", title: "Хранилище, настройки и Watchdog", readTime: "5 мин" },
      { slug: "architecture", title: "Архитектура ядра и Compose", readTime: "6 мин" }
    ]
  },
  {
    title: "Функции клиента",
    description: "Material 3 Expressive, режим невидимки, VLC-плеер и сетевые настройки",
    articles: [
      { slug: "themes", title: "Material 3 Expressive и темы Monet", readTime: "4 мин" },
      { slug: "privacy", title: "Приватность и Ghost Mode", readTime: "3 мин" },
      { slug: "media", title: "Встроенный медиаплеер VLC", readTime: "3 мин" },
      { slug: "proxy", title: "Умный прокси и автопинг", readTime: "4 мин" }
    ]
  },
  {
    title: "Поддержка",
    description: "Диагностика ошибок, безопасный режим и каналы связи",
    articles: [
      { slug: "troubleshooting", title: "Решение проблем и Safe Mode", readTime: "4 мин" },
      { slug: "community", title: "Сообщество и контакты", readTime: "2 мин" }
    ]
  }
];

export const kbPopularQuickLinks: Array<[string, string]> = [
  ["quickstart", "Быстрый старт плагинов"],
  ["hotreload", "Горячая перезагрузка"],
  ["api", "C API и HookParam"],
  ["privacy", "Приватность и Ghost Mode"],
  ["installation", "Установка на ПК"]
];

export const kbArticles: Record<string, KbArticle> = {
  "intro": {
    slug: "intro",
    title: "Введение в MandaGram",
    category: "Начало работы",
    readingTime: "3 мин чтения",
    sectionsCount: "4 раздела",
    prev: null,
    next: { slug: "installation", title: "Установка на Windows и Linux" },
    headings: [
      { level: 2, id: "what-is", text: "Что такое MandaGram" },
      { level: 2, id: "core-principles", text: "Ключевые принципы" },
      { level: 2, id: "tech-stack", text: "Технологический стек" },
      { level: 2, id: "comparison", text: "В чём отличие от TDesktop" }
    ],
    content: `
      <section id="what-is">
        <h2>Что такое MandaGram</h2>
        <p>MandaGram — это современный независимый клиент мессенджера Telegram для персональных компьютеров под управлением Windows и Linux. Он создан для пользователей и разработчиков, которым нужен полный визуальный и функциональный контроль над приложением: от глубокой кастомизации интерфейса в стиле Material 3 Expressive до возможности модифицировать поведение клиента нативными динамическими библиотеками на C++, Rust, Zig или D.</p>
      </section>

      <section id="core-principles">
        <h2>Ключевые принципы</h2>
        <ul>
          <li><strong>Никакого ИИ-шлака и лишнего мусора:</strong> клиент делает ровно то, о чём просит пользователь, не навязывая рекламные блоки, тяжелые фоновые службы и непрошенные подсказки.</li>
          <li><strong>Честная нативная расширяемость:</strong> плагины — это настоящие скомпилированные динамические библиотеки C ABI, работающие без медленных промежуточных виртуальных машин.</li>
          <li><strong>Горячая перезагрузка на лету:</strong> изменили код, собрали <code>.dll</code> или <code>.so</code> в папку плагинов — клиент подхватывает новую ревизию за доли секунды.</li>
          <li><strong>Безопасность и отказоустойчивость:</strong> если сторонний плагин завис или вызвал ошибку, сторожевой таймер Watchdog изолирует его и перезапустит в Safe Mode.</li>
        </ul>
      </section>

      <section id="tech-stack">
        <h2>Технологический стек</h2>
        <p>Клиент построен на стыке производительного сетевого ядра и современного декларативного UI:</p>
        <ul>
          <li><strong>TDLib (Telegram Database Library):</strong> официальная стабильная библиотека работы с протоколом MTProto, сквозным шифрованием и локальным кэшированием.</li>
          <li><strong>Compose Multiplatform Desktop:</strong> реактивный рендеринг с аппаратным ускорением GPU через Skia.</li>
          <li><strong>Material 3 Expressive:</strong> динамическая генерация палитр (ExteraMonet), скругления крупных радиусов и шрифты Google Sans Flex.</li>
          <li><strong>LibVLC Core:</strong> медиадвижок для бесшовного проигрывания любых форматов видео, аудиосообщений и стримов.</li>
        </ul>
      </section>

      <section id="comparison">
        <h2>В чём отличие от TDesktop</h2>
        <p>Официальный Telegram Desktop написан на Qt/C++ и ориентирован на массовую аудиторию с жестко фиксированной функциональностью. MandaGram развивает идеи расширяемости, знакомые сообществу по exteraGram на Android, перенося модульную архитектуру и гибкие хуки в нативную десктопную среду.</p>
      </section>
    `
  },

  "installation": {
    slug: "installation",
    title: "Установка на Windows и Linux",
    category: "Начало работы",
    readingTime: "4 мин чтения",
    sectionsCount: "4 раздела",
    prev: { slug: "intro", title: "Введение в MandaGram" },
    next: { slug: "hotkeys", title: "Горячие клавиши и шорткаты" },
    headings: [
      { level: 2, id: "windows", text: "Установка на Windows" },
      { level: 2, id: "linux", text: "Установка на Linux" },
      { level: 2, id: "paths", text: "Каталоги данных и плагинов" },
      { level: 2, id: "requirements", text: "Системные требования" }
    ],
    content: `
      <section id="windows">
        <h2>Установка на Windows</h2>
        <p>Для платформы Windows 10 и 11 (64-бит) доступны два варианта сборки:</p>
        <ul>
          <li><strong>Установщик (.exe):</strong> стандартный мастер инсталляции, добавляющий ярлыки в меню «Пуск», регистрацию протокола <code>tg://</code> и интеграцию в контекстное меню трея.</li>
          <li><strong>Портативная версия (.zip):</strong> полностью автономный архив. Распакуйте в любую удобную папку (например, <code>D:\\Apps\\MandaGram</code>). Все настройки, плагины и кэш сессий сохраняются рядом с исполняемым файлом.</li>
        </ul>
      </section>

      <section id="linux">
        <h2>Установка на Linux</h2>
        <p>Для пользователей дистрибутивов Linux x86_64 подготовлены универсальные пакеты:</p>
        <div class="code-block">
          <div class="code-header">
            <span>Терминал Linux</span>
          </div>
          <div class="code-content">
<pre><span class="com"># Сделайте AppImage исполняемым и запустите:</span>
chmod +x MandaGram-x86_64.AppImage
./MandaGram-x86_64.AppImage</pre>
          </div>
        </div>
        <p>Также доступен классический архив <code>tar.gz</code> для ручной интеграции в систему.</p>
      </section>

      <section id="paths">
        <h2>Каталоги данных и плагинов</h2>
        <p>При первом запуске клиент создает необходимую файловую структуру:</p>
        <ul>
          <li><code>plugins/</code> — папка для пользовательских нативных плагинов (<code>.dll</code> или <code>.so</code>).</li>
          <li><code>plugins/data/&lt;name&gt;/</code> — изолированные директории постоянных настроек каждого плагина.</li>
          <li><code>plugins/cache/&lt;name&gt;/</code> — временный кэш плагинов (очищается при необходимости).</li>
          <li><code>plugins/.cache/</code> — служебная директория для горячей перезагрузки (теневые копии библиотек).</li>
        </ul>
      </section>

      <section id="requirements">
        <h2>Системные требования</h2>
        <ul>
          <li><strong>ОС:</strong> Windows 10/11 x64 или Linux glibc 2.31+ x86_64.</li>
          <li><strong>ОЗУ:</strong> от 2 ГБ (рекомендуется 4 ГБ при активном использовании медиа-галерей).</li>
          <li><strong>Видеокарта:</strong> с поддержкой OpenGL 3.3+ или DirectX 11 для плавных Compose-анимаций.</li>
        </ul>
      </section>
    `
  },

  "hotkeys": {
    slug: "hotkeys",
    title: "Горячие клавиши и шорткаты",
    category: "Начало работы",
    readingTime: "3 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "installation", title: "Установка на Windows и Linux" },
    next: { slug: "quickstart", title: "Быстрый старт: первый плагин" },
    headings: [
      { level: 2, id: "formatting", text: "Форматирование текста" },
      { level: 2, id: "chat-actions", text: "Действия в чате" },
      { level: 2, id: "system-keys", text: "Глобальные и системные клавиши" }
    ],
    content: `
      <section id="formatting">
        <h2>Форматирование текста</h2>
        <p>В строке ввода MandaGram поддерживаются стандартные комбинации клавиш для оформления разметки:</p>
        <ul>
          <li><code>Ctrl + B</code> — <strong>Жирный шрифт</strong></li>
          <li><code>Ctrl + I</code> — <em>Курсив</em></li>
          <li><code>Ctrl + U</code> — <u>Подчёркнутый текст</u></li>
          <li><code>Ctrl + Shift + M</code> — <code>Моноширинный код</code></li>
          <li><code>Ctrl + Shift + X</code> — <s>Зачёркнутый текст</s></li>
          <li><code>Ctrl + Shift + P</code> — Спойлер (скрытый текст)</li>
          <li><code>Ctrl + Shift + .</code> — Цитата</li>
          <li><code>Ctrl + Shift + N</code> — Очистить всё форматирование</li>
        </ul>
      </section>

      <section id="chat-actions">
        <h2>Действия в чате</h2>
        <ul>
          <li><code>Ctrl + P</code> — <strong>Предпросмотр чата (Ghost Mode)</strong> без отметки о прочтении входящих сообщений.</li>
          <li><code>Ctrl + M</code> — Включить / выключить звук уведомлений выбранного чата.</li>
          <li><code>Ctrl + Shift + R</code> — Пометить чат прочитанным вручную.</li>
          <li><code>Ctrl + Shift + F</code> — Поиск сообщений по текущему диалогу.</li>
        </ul>
      </section>

      <section id="system-keys">
        <h2>Глобальные и системные клавиши</h2>
        <ul>
          <li><code>Ctrl + Shift + Escape</code> — <strong>Panic Mode:</strong> мгновенное сворачивание приложения в трей и блокировка пин-кодом.</li>
          <li><code>Ctrl + L</code> — Блокировка клиента экраном AppLock.</li>
          <li><code>Ctrl + Alt + P</code> — Открыть панель установленных нативных плагинов.</li>
        </ul>
      </section>
    `
  },

  "quickstart": {
    slug: "quickstart",
    title: "Быстрый старт: первый плагин",
    category: "Разработка плагинов",
    readingTime: "5 мин чтения",
    sectionsCount: "4 раздела",
    prev: { slug: "hotkeys", title: "Горячие клавиши и шорткаты" },
    next: { slug: "api", title: "C API и перехват методов" },
    headings: [
      { level: 2, id: "how-it-works", text: "Как устроен плагин MandaGram" },
      { level: 2, id: "exports", text: "Экспортируемые функции" },
      { level: 2, id: "minimal-example", text: "Минимальный пример (C++)" },
      { level: 2, id: "compile", text: "Сборка в одну строку" }
    ],
    content: `
      <section id="how-it-works">
        <h2>Как устроен плагин MandaGram</h2>
        <p>Плагин MandaGram — это нативная динамическая библиотека (<code>.dll</code> на Windows, <code>.so</code> на Linux), помещаемая в папку <code>plugins/</code>. Клиент автоматически отслеживает состояние файлов на диске и перезагружает плагин на лету при перезаписи.</p>
        <p>Взаимодействие между ядром клиента и плагином происходит через открытый C ABI, что позволяет писать расширения на любом языке, поддерживающем экспорт C-функций: C++, Rust, Zig, D, Nim, C и других.</p>
      </section>

      <section id="exports">
        <h2>Экспортируемые функции</h2>
        <p>Каждая библиотека плагина обязана экспортировать две функции с соглашением о вызовах C:</p>
        <div class="code-block">
          <div class="code-header">
            <span>C ABI Signature</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">const</span> <span class="typ">PluginMetadata*</span> mandagram_plugin_metadata(<span class="kwd">void</span>);
<span class="typ">bool</span> mandagram_plugin_init(<span class="kwd">const</span> <span class="typ">PluginApi*</span> api);</pre>
          </div>
        </div>
        <p>Возврат <code>true</code> из <code>mandagram_plugin_init</code> активирует плагин. Метаданные (название, версия, автор, описание) отображаются напрямую в интерфейсе настроек клиента.</p>
      </section>

      <section id="minimal-example">
        <h2>Минимальный пример (C++)</h2>
        <div class="code-block">
          <div class="code-header">
            <span>plugin.cpp</span>
          </div>
          <div class="code-content">
<pre><span class="com">#include "mandagram_plugin.h"</span>

<span class="kwd">static</span> <span class="typ">PluginMetadata</span> s_meta = {
    .name = <span class="str">"Hello Plugin"</span>,
    .version = <span class="str">"1.0.0"</span>,
    .author = <span class="str">"Dev"</span>,
    .description = <span class="str">"Мой первый нативный плагин для MandaGram"</span>,
    .api_version = <span class="num">1</span>
};

<span class="kwd">extern</span> <span class="str">"C"</span> {
    <span class="typ">MANDAGRAM_EXPORT</span> <span class="kwd">const</span> <span class="typ">PluginMetadata*</span> mandagram_plugin_metadata(<span class="kwd">void</span>) {
        <span class="kwd">return</span> &s_meta;
    }

    <span class="typ">MANDAGRAM_EXPORT</span> <span class="typ">bool</span> mandagram_plugin_init(<span class="kwd">const</span> <span class="typ">PluginApi*</span> api) {
        api->log_info(<span class="str">"Плагин успешно загружен в MandaGram!"</span>);
        <span class="kwd">return</span> <span class="kwd">true</span>;
    }
}</pre>
          </div>
        </div>
      </section>

      <section id="compile">
        <h2>Сборка в одну строку</h2>
        <ul>
          <li><strong>C++ (MSVC / Clang):</strong> <code>clang++ -shared -O3 -Iinclude plugin.cpp -o plugins/my_plugin.dll</code></li>
          <li><strong>Zig:</strong> <code>zig build-lib -dynamic plugin.zig -O ReleaseFast</code></li>
          <li><strong>Rust:</strong> <code>cargo build --release</code> (crate-type <code>["cdylib"]</code>)</li>
          <li><strong>D:</strong> <code>ldc2 -shared -betterC mandagram_plugin.d</code></li>
        </ul>
      </section>
    `
  },

  "api": {
    slug: "api",
    title: "C API и перехват методов",
    category: "Разработка плагинов",
    readingTime: "6 мин чтения",
    sectionsCount: "4 раздела",
    prev: { slug: "quickstart", title: "Быстрый старт: первый плагин" },
    next: { slug: "examples", title: "Примеры на C++, Rust, Zig и D" },
    headings: [
      { level: 2, id: "header", text: "Заголовочный файл mandagram_plugin.h" },
      { level: 2, id: "hookparam", text: "Структура HookParam" },
      { level: 2, id: "method-hooks", text: "Хуки Before и After" },
      { level: 2, id: "message-hooks", text: "Хуки отправки сообщений TDLib" }
    ],
    content: `
      <section id="header">
        <h2>Заголовочный файл mandagram_plugin.h</h2>
        <p>Официальный интерфейс C API декларируется в заголовочных файлах <code>mandagram_plugin.h</code> (чистый C) и <code>mandagram_plugin.hpp</code> (обертки C++17/20).</p>
        <p>API гарантирует бинарную совместимость между минорными релизами клиента MandaGram.</p>
      </section>

      <section id="hookparam">
        <h2>Структура HookParam</h2>
        <p>При срабатывании перехваченного метода клиент передает структуру с полным контекстом вызова:</p>
        <div class="code-block">
          <div class="code-header">
            <span>mandagram_plugin.h</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">typedef struct</span> <span class="typ">HookParam</span> {
    <span class="typ">void*</span>    env;          <span class="com">// JNIEnv указатель</span>
    <span class="typ">void*</span>    this_ptr;     <span class="com">// Указатель на экземпляр вызываемого объекта</span>
    <span class="typ">void**</span>   args;         <span class="com">// Массив указателей на аргументы метода</span>
    <span class="typ">uint32_t</span> args_count;   <span class="com">// Количество аргументов</span>
    <span class="typ">uint32_t</span> padding;
    <span class="typ">void*</span>    result;       <span class="com">// Возвращаемое значение метода</span>
    <span class="typ">uint8_t</span>  return_early; <span class="com">// Установите 1 для отмены оригинального метода</span>
    <span class="typ">uint8_t</span>  has_result;   <span class="com">// Установите 1, если подставили собственное значение</span>
    <span class="typ">uint16_t</span> reserved;
} <span class="typ">HookParam</span>;</pre>
          </div>
        </div>
      </section>

      <section id="method-hooks">
        <h2>Хуки Before и After</h2>
        <ul>
          <li><strong>Before Hook:</strong> вызывается перед оригинальным кодом метода. Плагин может модифицировать входные аргументы (через <code>param->args</code>) или досрочно вернуть управление (установив <code>return_early = 1</code> и записав собственное значение в <code>param->result</code>).</li>
          <li><strong>After Hook:</strong> вызывается после завершения оригинального метода. Позволяет прочитать или подменить вычисленный результат <code>param->result</code>.</li>
        </ul>
      </section>

      <section id="message-hooks">
        <h2>Хуки отправки сообщений TDLib</h2>
        <p>Высокоуровневый API позволяет регистрировать перехватчики исходящих сообщений:</p>
        <div class="code-block">
          <div class="code-header">
            <span>C API</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">typedef bool</span> (*<span class="typ">MessageSendHookFn</span>)(<span class="typ">int64_t</span> chat_id, <span class="kwd">char**</span> text_inout);
api->register_message_send_hook(my_message_filter);</pre>
          </div>
        </div>
        <p>Функция-фильтр может изменить текст сообщения на лету или вернуть <code>false</code> для отмены отправки.</p>
      </section>
    `
  },

  "examples": {
    slug: "examples",
    title: "Примеры на C++, Rust, Zig и D",
    category: "Разработка плагинов",
    readingTime: "7 мин чтения",
    sectionsCount: "4 раздела",
    prev: { slug: "api", title: "C API и перехват методов" },
    next: { slug: "hotreload", title: "Горячая перезагрузка (Hot-Reload)" },
    headings: [
      { level: 2, id: "cpp", text: "Пример на C++" },
      { level: 2, id: "rust", text: "Пример на Rust" },
      { level: 2, id: "zig", text: "Пример на Zig" },
      { level: 2, id: "d", text: "Пример на D (betterC)" }
    ],
    content: `
      <section id="cpp">
        <h2>Пример на C++</h2>
        <p>Плагин перехватывает отправку сообщений и форматирует текст:</p>
        <div class="code-block">
          <div class="code-header">
            <span>examples/cpp/plugin.cpp</span>
          </div>
          <div class="code-content">
<pre><span class="com">#include "mandagram_plugin.hpp"</span>
<span class="com">#include &lt;string&gt;</span>
<span class="com">#include &lt;algorithm&gt;</span>

<span class="kwd">static bool</span> OnSendMessage(<span class="typ">int64_t</span> chat_id, <span class="typ">char**</span> text_ptr) {
    <span class="kwd">if</span> (!text_ptr || !*text_ptr) <span class="kwd">return true</span>;
    <span class="typ">std::string</span> s(*text_ptr);
    <span class="com">// Преобразуем команду .shout в верхний регистр</span>
    <span class="kwd">if</span> (s.rfind(<span class="str">".shout "</span>, <span class="num">0</span>) == <span class="num">0</span>) {
        s = s.substr(<span class="num">7</span>);
        <span class="kwd">for</span> (<span class="kwd">auto</span>& c : s) c = toupper(c);
        *text_ptr = strdup(s.c_str());
    }
    <span class="kwd">return true</span>;
}

<span class="typ">MANDAGRAM_EXPORT bool</span> mandagram_plugin_init(<span class="kwd">const</span> <span class="typ">PluginApi*</span> api) {
    api->register_message_send_hook(OnSendMessage);
    <span class="kwd">return true</span>;
}</pre>
          </div>
        </div>
      </section>

      <section id="rust">
        <h2>Пример на Rust</h2>
        <p>Использование <code>cdylib</code> в <code>Cargo.toml</code>:</p>
        <div class="code-block">
          <div class="code-header">
            <span>examples/rust/src/lib.rs</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">use</span> std::ffi::{CStr, c_char};

<span class="attr">#[no_mangle]</span>
<span class="kwd">pub extern "C" fn</span> mandagram_plugin_init(api: *<span class="kwd">const</span> PluginApi) -> <span class="kwd">bool</span> {
    <span class="kwd">unsafe</span> {
        <span class="kwd">if let Some</span>(log) = (*api).log_info {
            log(b<span class="str">"Rust plugin initialized!\0"</span>.as_ptr() <span class="kwd">as</span> *<span class="kwd">const</span> c_char);
        }
    }
    <span class="kwd">true</span>
}</pre>
          </div>
        </div>
      </section>

      <section id="zig">
        <h2>Пример на Zig</h2>
        <div class="code-block">
          <div class="code-header">
            <span>examples/zig/plugin.zig</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">const</span> std = @import(<span class="str">"std"</span>);

<span class="kwd">export fn</span> mandagram_plugin_init(api: *<span class="kwd">const</span> PluginApi) <span class="kwd">bool</span> {
    api.log_info(<span class="str">"Zig plugin active on MandaGram Desktop!"</span>);
    <span class="kwd">return true</span>;
}</pre>
          </div>
        </div>
      </section>

      <section id="d">
        <h2>Пример на D (betterC)</h2>
        <p>Компиляция без рантайма языка (D runtime) даёт ультралегковесный <code>.dll</code> размером всего несколько килобайт:</p>
        <div class="code-block">
          <div class="code-header">
            <span>examples/d/plugin.d</span>
          </div>
          <div class="code-content">
<pre><span class="kwd">import</span> core.stdc.stdio;

<span class="kwd">extern</span>(C) <span class="kwd">export bool</span> mandagram_plugin_init(<span class="kwd">const</span> <span class="typ">PluginApi*</span> api) {
    api.log_info(<span class="str">"D -betterC plugin hooked successfully"</span>);
    <span class="kwd">return true</span>;
}</pre>
          </div>
        </div>
      </section>
    `
  },

  "hotreload": {
    slug: "hotreload",
    title: "Горячая перезагрузка (Hot-Reload)",
    category: "Разработка плагинов",
    readingTime: "4 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "examples", title: "Примеры на C++, Rust, Zig и D" },
    next: { slug: "storage", title: "Хранилище, настройки и Watchdog" },
    headings: [
      { level: 2, id: "mechanism", text: "Механика горячей перезагрузки" },
      { level: 2, id: "shadow-copies", text: "Теневые копии и блокировки файлов" },
      { level: 2, id: "lifecycle", text: "Жизненный цикл плагина" }
    ],
    content: `
      <section id="mechanism">
        <h2>Механика горячей перезагрузки</h2>
        <p>MandaGram включает файловый монитор каталога <code>plugins/</code>. Когда вы перекомпилируете свой плагин, операционная система уведомляет клиент о записи нового файла. Клиент выполняет цикл перезагрузки:</p>
        <ol>
          <li>Вызывается функция деинициализации текущего плагина (если экспортирован <code>mandagram_plugin_deinit</code>).</li>
          <li>Снимаются все зарегистрированные хуки методов JVM и перехватчики сообщений TDLib.</li>
          <li>Выгружается предыдущая динамическая библиотека.</li>
          <li>Загружается новая версия, проверяются метаданные и вызывается <code>mandagram_plugin_init</code>.</li>
        </ol>
      </section>

      <section id="shadow-copies">
        <h2>Теневые копии и блокировки файлов</h2>
        <p>В Windows загруженная через <code>LoadLibrary</code> DLL блокируется операционной системой от перезаписи компилятором. Чтобы обойти это ограничение, MandaGram использует теневое копирование:</p>
        <p>При обнаружении <code>plugins/my_plugin.dll</code> клиент копирует файл в <code>plugins/.cache/my_plugin_&lt;hash&gt;.dll</code> и загружает именно эту копию. Исходный файл в <code>plugins/</code> всегда остаётся свободным для перезаписи компилятором или IDE.</p>
      </section>

      <section id="lifecycle">
        <h2>Жизненный цикл плагина</h2>
        <p>Время полного цикла перезагрузки плагина составляет в среднем <strong>10–15 миллисекунд</strong>, что позволяет тестировать изменения прямо во время живой переписки в чате.</p>
      </section>
    `
  },

  "storage": {
    slug: "storage",
    title: "Хранилище, настройки и Watchdog",
    category: "Разработка плагинов",
    readingTime: "5 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "hotreload", title: "Горячая перезагрузка (Hot-Reload)" },
    next: { slug: "architecture", title: "Архитектура ядра и Compose" },
    headings: [
      { level: 2, id: "isolated-storage", text: "Изолированное хранилище данных" },
      { level: 2, id: "declarative-ui", text: "Декларативные настройки UI" },
      { level: 2, id: "watchdog", text: "Защита Watchdog и Safe Mode" }
    ],
    content: `
      <section id="isolated-storage">
        <h2>Изолированное хранилище данных</h2>
        <p>Каждому плагину выделяются персональные пути на диске:</p>
        <ul>
          <li><code>plugins/data/&lt;plugin_name&gt;/</code> — постоянное хранилище настроек, конфигурационных файлов и баз данных плагина. Сохраняется при обновлениях.</li>
          <li><code>plugins/cache/&lt;plugin_name&gt;/</code> — кэш временных файлов (может быть очищен пользователем в настройках).</li>
        </ul>
        <p>Плагин может запросить эти пути через <code>api->get_data_dir()</code> и <code>api->get_cache_dir()</code>.</p>
      </section>

      <section id="declarative-ui">
        <h2>Декларативные настройки UI</h2>
        <p>Плагинам не нужно вручную верстать окна настроек. Достаточно экспортировать схему настроек, и MandaGram автоматически сгенерирует окно конфигурации с аутентичными компонентами Material 3 Expressive (переключатели, текстовые поля, выпадающие списки).</p>
      </section>

      <section id="watchdog">
        <h2>Защита Watchdog и Safe Mode</h2>
        <p>Сторожевой таймер Watchdog предотвращает зависание графического интерфейса клиента:</p>
        <ul>
          <li>Если обработчик хука в нативном коде плагина выполняется дольше заданного таймаута (по умолчанию <strong>2500 мс</strong>), поток отсекается.</li>
          <li>При повторяющихся критических сбоях плагин временно отключается, а клиент переходит в <strong>Safe Mode</strong> с уведомлением пользователя.</li>
        </ul>
      </section>
    `
  },

  "architecture": {
    slug: "architecture",
    title: "Архитектура ядра и Compose",
    category: "Разработка плагинов",
    readingTime: "6 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "storage", title: "Хранилище, настройки и Watchdog" },
    next: { slug: "themes", title: "Material 3 Expressive и темы Monet" },
    headings: [
      { level: 2, id: "jni-bridge", text: "JNI-мост и ByteBuddy Agent" },
      { level: 2, id: "compose-slots", text: "Compose Multiplatform Slot API" },
      { level: 2, id: "tdlib-flow", text: "Интеграция с потоком событий TDLib" }
    ],
    content: `
      <section id="jni-bridge">
        <h2>JNI-мост и ByteBuddy Agent</h2>
        <p>Архитектура хуков MandaGram объединяет Java Native Interface (JNI) и динамическое переписывание байткода с помощью ByteBuddy. Это позволяет перехватывать вызовы внутренних методов клиента без необходимости декомпилировать или пересобирать само приложение.</p>
      </section>

      <section id="compose-slots">
        <h2>Compose Multiplatform Slot API</h2>
        <p>Для модификации внешнего вида чатов реализован Slot API: плагин может встроить свой кастомный Composable-компонент в:</p>
        <ul>
          <li>Шапку диалога (кнопки быстрых действий, статус-индикаторы).</li>
          <li>Пузырь сообщения (MessageBubble — кастомные бейджи, кнопки, метаданные).</li>
          <li>Панель ввода (дополнительные панели стикеров, форматирования, шаблонов).</li>
        </ul>
      </section>

      <section id="tdlib-flow">
        <h2>Интеграция с потоком событий TDLib</h2>
        <p>События входящих и исходящих данных TDLib передаются в диспетчер хуков, позволяя фильтровать, обогащать или логировать сетевые события в реальном времени.</p>
      </section>
    `
  },

  "themes": {
    slug: "themes",
    title: "Material 3 Expressive и темы Monet",
    category: "Функции клиента",
    readingTime: "4 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "architecture", title: "Архитектура ядра и Compose" },
    next: { slug: "privacy", title: "Приватность и Ghost Mode" },
    headings: [
      { level: 2, id: "m3e-overview", text: "Философия Material 3 Expressive" },
      { level: 2, id: "monet-palettes", text: "Палитры ExteraMonet" },
      { level: 2, id: "typography", text: "Типографика Google Sans Flex" }
    ],
    content: `
      <section id="m3e-overview">
        <h2>Философия Material 3 Expressive</h2>
        <p>MandaGram переносит на десктоп новейший визуальный язык Google — <strong>Material 3 Expressive</strong>. Это не просто плоские карточки: интерфейс насыщен тактильными переходами, органическими радиусами скругления кнопок и панелей, адаптивными контейнерами и мягкими тенями.</p>
      </section>

      <section id="monet-palettes">
        <h2>Палитры ExteraMonet</h2>
        <p>В клиенте реализован генератор динамических цветовых схем. Доступны фирменные палитры:</p>
        <ul>
          <li><strong>Evening Red (Вечерний красный):</strong> глубокая терракотовая тема по умолчанию (<code>#8E3C32</code>).</li>
          <li><strong>Pistachio (Фисташка):</strong> мягкий природный зелёный оттенок (<code>#386A20</code>).</li>
          <li><strong>Lavender (Лаванда):</strong> пастельный фиолетово-сиреневый акцент (<code>#7C52FF</code>).</li>
          <li><strong>Ocean, Peach, Slate:</strong> сбалансированные альтернативные темы для любого настроения.</li>
        </ul>
      </section>

      <section id="typography">
        <h2>Типографика Google Sans Flex</h2>
        <p>Встроенные вариативные шрифты Google Sans и Google Sans Flex обеспечивают читаемость длинных тредов и идеальное отображение кириллических и латинских символов на экранах любого разрешения.</p>
      </section>
    `
  },

  "privacy": {
    slug: "privacy",
    title: "Приватность и Ghost Mode",
    category: "Функции клиента",
    readingTime: "3 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "themes", title: "Material 3 Expressive и темы Monet" },
    next: { slug: "media", title: "Встроенный медиаплеер VLC" },
    headings: [
      { level: 2, id: "ghost-mode", text: "Режим невидимки (Ghost Mode)" },
      { level: 2, id: "typing-status", text: "Скрытие статуса набора текста" },
      { level: 2, id: "app-lock", text: "Защита приложения AppLock" }
    ],
    content: `
      <section id="ghost-mode">
        <h2>Режим невидимки (Ghost Mode)</h2>
        <p>В официальном клиенте открытие любого чата сразу шлёт вызов <code>viewMessages</code>, из-за чего сообщения мгновенно помечаются прочитанными. В MandaGram вы сами решаете, когда отмечать диалог:</p>
        <ul>
          <li>По нажатию <code>Ctrl + P</code> открывается удобный предпросмотр чата без отправки отчёта о прочтении на сервер.</li>
          <li>Собеседник не видит двух галочек, пока вы сами не ответите или не нажмёте «Пометить прочитанным» (<code>Ctrl + Shift + R</code>).</li>
        </ul>
      </section>

      <section id="typing-status">
        <h2>Скрытие статуса набора текста</h2>
        <p>При включении этой опции MandaGram полностью отключает отправку пакетов <code>sendChatAction</code> на сервер Telegram. Собеседники в личке и в группах не видят плашку «печатает...», пока вы набираете или редактируете текст.</p>
      </section>

      <section id="app-lock">
        <h2>Защита приложения AppLock</h2>
        <p>Локальный PIN-код или пароль на запуск приложения защищает переписки от посторонних глаз. Доступна автоблокировка по таймеру неактивности (от 1 до 60 минут), если отошли от ноутбука.</p>
      </section>
    `
  },

  "media": {
    slug: "media",
    title: "Встроенный медиаплеер VLC",
    category: "Функции клиента",
    readingTime: "3 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "privacy", title: "Приватность и Ghost Mode" },
    next: { slug: "proxy", title: "Умный прокси и автопинг" },
    headings: [
      { level: 2, id: "libvlc", text: "Движок LibVLC" },
      { level: 2, id: "codecs", text: "Поддерживаемые форматы" },
      { level: 2, id: "performance", text: "Производительность и аппаратное декодирование" }
    ],
    content: `
      <section id="libvlc">
        <h2>Движок LibVLC</h2>
        <p>Официальные клиенты часто страдают от проблем с воспроизведением редких аудиоформатов или 4K-видео из-за зависимости от системных декодеров Windows Media Foundation. MandaGram включает встроенную библиотеку <strong>LibVLC</strong>, которая обрабатывает мультимедиа автономно.</p>
      </section>

      <section id="codecs">
        <h2>Поддерживаемые форматы</h2>
        <ul>
          <li><strong>Видео:</strong> H.264, HEVC / H.265, AV1, VP9, MPEG-4, WebM, MKV, MP4.</li>
          <li><strong>Аудио:</strong> FLAC, Opus, AAC, MP3, OGG, WAV, ALAC.</li>
          <li><strong>Кружки и видеосообщения:</strong> плавное зацикливание без задержек перед стартом.</li>
        </ul>
      </section>

      <section id="performance">
        <h2>Производительность и аппаратное декодирование</h2>
        <p>Медиапоток рендерится напрямую через аппаратные интерфейсы видеокарты (DirectX Video Acceleration / VA-API), что сохраняет низкую загрузку центрального процессора и низкую температуру ноутбука.</p>
      </section>
    `
  },

  "proxy": {
    slug: "proxy",
    title: "Умный прокси и автопинг",
    category: "Функции клиента",
    readingTime: "4 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "media", title: "Встроенный медиаплеер VLC" },
    next: { slug: "troubleshooting", title: "Решение проблем и Safe Mode" },
    headings: [
      { level: 2, id: "protocols", text: "Поддерживаемые протоколы" },
      { level: 2, id: "auto-switch", text: "Автоматический выбор наименьшего пинга" },
      { level: 2, id: "import", text: "Импорт настроек по ссылке и QR" }
    ],
    content: `
      <section id="protocols">
        <h2>Поддерживаемые протоколы</h2>
        <p>MandaGram поддерживает работу со всеми популярными типами прокси-серверов:</p>
        <ul>
          <li><strong>MTProto Proxy</strong> — специализированный протокол Telegram с маскировкой трафика.</li>
          <li><strong>SOCKS5</strong> — с поддержкой авторизации по логину и паролю.</li>
          <li><strong>HTTP / HTTPS Connect</strong> — корпоративные прокси-туннели.</li>
        </ul>
      </section>

      <section id="auto-switch">
        <h2>Автоматический выбор наименьшего пинга</h2>
        <p>Клиент периодически тестирует соединение с добавленными серверами в фоне. Если основной прокси начинает задерживать пакеты или терять связь, MandaGram бесшовно переключается на резервный сервер без прерывания звонков и загрузки медиа.</p>
      </section>

      <section id="import">
        <h2>Импорт настроек по ссылке и QR</h2>
        <p>Добавить прокси можно кликом по ссылке <code>tg://proxy?server=...</code> или сканированием QR-кода прямо в диалоговом окне настроек сети.</p>
      </section>
    `
  },

  "troubleshooting": {
    slug: "troubleshooting",
    title: "Решение проблем и Safe Mode",
    category: "Поддержка",
    readingTime: "4 мин чтения",
    sectionsCount: "3 раздела",
    prev: { slug: "proxy", title: "Умный прокси и автопинг" },
    next: { slug: "community", title: "Сообщество и контакты" },
    headings: [
      { level: 2, id: "plugin-issues", text: "Плагин не загружается" },
      { level: 2, id: "safe-mode", text: "Как выйти из Safe Mode" },
      { level: 2, id: "reset-cache", text: "Очистка кэша и логов" }
    ],
    content: `
      <section id="plugin-issues">
        <h2>Плагин не загружается</h2>
        <p>Если вы положили библиотеку в <code>plugins/</code>, но клиент её не видит:</p>
        <ul>
          <li>Убедитесь, что библиотека скомпилирована под <strong>64-битную архитектуру (x86_64 / amd64)</strong>. 32-битные DLL не загружаются 64-битным процессом.</li>
          <li>Проверьте, экспортирует ли файл функции <code>mandagram_plugin_metadata</code> и <code>mandagram_plugin_init</code> без C++ name mangling (должен быть блок <code>extern "C"</code>).</li>
          <li>Откройте журнал в настройках (<code>Ctrl + Alt + L</code>) для просмотра диагностических сообщений.</li>
        </ul>
      </section>

      <section id="safe-mode">
        <h2>Как выйти из Safe Mode</h2>
        <p>Если клиент запустился в безопасном режиме (Safe Mode):</p>
        <ol>
          <li>Все нативные плагины временно отключены для обеспечения стабильности.</li>
          <li>Перейдите в <em>Настройки → Плагины</em> и найдите плагин, вызвавший сбой.</li>
          <li>Удалите проблемный файл из каталога <code>plugins/</code> или обновите его на исправленную версию.</li>
          <li>Нажмите кнопку «Перезапустить в обычном режиме».</li>
        </ol>
      </section>

      <section id="reset-cache">
        <h2>Очистка кэша и логов</h2>
        <p>Если возникают сложности с горячей перезагрузкой, просто удалите каталог <code>plugins/.cache/</code> при закрытом приложении.</p>
      </section>
    `
  },

  "community": {
    slug: "community",
    title: "Сообщество и контакты",
    category: "Поддержка",
    readingTime: "2 мин чтения",
    sectionsCount: "2 раздела",
    prev: { slug: "troubleshooting", title: "Решение проблем и Safe Mode" },
    next: null,
    headings: [
      { level: 2, id: "channels", text: "Официальные каналы" },
      { level: 2, id: "contributing", text: "Разработка и вклад в проект" }
    ],
    content: `
      <section id="channels">
        <h2>Официальные каналы</h2>
        <p>Следите за новостями проекта и общайтесь с сообществом:</p>
        <ul>
          <li><strong>Telegram-канал:</strong> <a href="https://t.me/MandaGram" target="_blank" rel="noopener">@MandaGram</a> — официальные новости и релизы.</li>
          <li><strong>Канал с бетами:</strong> <a href="https://t.me/MandaBeta" target="_blank" rel="noopener">@MandaBeta</a> — тестовые ночные сборки и ранний доступ.</li>
          <li><strong>КБТ:</strong> <a href="https://t.me/+orCNbISKx9dkYjgy" target="_blank" rel="noopener">t.me/+orCNbISKx9dkYjgy</a> — обсуждение плагинов, C ABI и хуков.</li>
          <li><strong>GitHub:</strong> <a href="https://github.com/GrapeS-T/MandaGram" target="_blank" rel="noopener">github.com/GrapeS-T/MandaGram</a> — открытый исходный код, релизы и трекер задач.</li>
        </ul>
      </section>

      <section id="contributing">
        <h2>Разработка и вклад в проект</h2>
        <p>MandaGram приветствует пулреквесты, документацию плагинов и примеры на новых языках программирования. Ознакомьтесь с правилами оформления кода в репозитории проекта.</p>
      </section>
    `
  }
};

export const kbSearchData = {
  a: [['intro', 'Введение в MandaGram', 'Начало работы', 'архитектура концепция tdlib desktop'], ['installation', 'Установка на Windows и Linux', 'Начало работы', 'установка portable exe appimage скачать'], ['hotkeys', 'Горячие клавиши и шорткаты', 'Начало работы', 'горячие клавиши шорткаты форматирование ctrl'], ['quickstart', 'Быстрый старт: первый плагин', 'Разработка плагинов', 'быстрый старт mandagram_plugin_init c abi'], ['api', 'C API и перехват методов', 'Разработка плагинов', 'c api hookparam hook before after'], ['examples', 'Примеры на C++, Rust, Zig и D', 'Разработка плагинов', 'примеры cpp rust zig d betterc'], ['hotreload', 'Горячая перезагрузка (Hot-Reload)', 'Разработка плагинов', 'горячая перезагрузка без перезапуска'], ['storage', 'Хранилище, настройки и Watchdog', 'Разработка плагинов', 'watchdog safe mode хранилище data cache'], ['architecture', 'Архитектура ядра и Compose', 'Разработка плагинов', 'архитектура jni bytebuddy slot api'], ['themes', 'Material 3 Expressive и темы Monet', 'Функции клиента', 'темы monet evening red pistachio lavender google sans'], ['privacy', 'Приватность, Ghost Mode и Panic Mode', 'Функции клиента', 'невидимка предпросмотр без галочек panic mode'], ['media', 'Встроенный медиаплеер VLC', 'Функции клиента', 'vlc плеер видео аудио кодеки аппаратное'], ['proxy', 'Умный прокси и автопинг', 'Функции клиента', 'прокси mtproto socks5 пинг автопереключение'], ['troubleshooting', 'Решение проблем и Safe Mode', 'Поддержка', 'ошибки safe mode сбои не загружается плагин'], ['community', 'Сообщество и контакты', 'Поддержка', 'сообщество telegram чат github issues']]
};
