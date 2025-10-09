import SwiftUI
import WebKit
import AVFoundation

struct StableWebView: View {
    let url: URL
    let onNavigation: (WKNavigation) -> Void
    
    var body: some View {
        WebViewWrapper(url: url, onNavigation: onNavigation)
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let url: URL
    let onNavigation: (WKNavigation) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        // Настройки для медиа - максимально агрессивные
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        
        // Настройки для JavaScript
        if #available(iOS 14.0, *) {
            configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        }
        
        // Настройки для загрузки контента
        configuration.suppressesIncrementalRendering = false
        
        // Дополнительные настройки для медиа
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        // Настройки для аудио сессии - максимально агрессивные
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetoothHFP, .allowBluetoothA2DP, .mixWithOthers, .defaultToSpeaker, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true, options: [])
        } catch {
            // Пробуем более простую конфигурацию
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                // Игнорируем ошибки аудио сессии
            }
        }
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = false
        
        // Дополнительные настройки для стабильности
        webView.allowsBackForwardNavigationGestures = false
        webView.allowsLinkPreview = false
        
        // Настройки для медиа
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        
        // Принудительная настройка User-Agent для мобильного контента
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        
        // Загружаем URL сразу с правильным User-Agent
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")
        request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField: "Accept")
        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("en-US,en;q=0.9", forHTTPHeaderField: "Accept-Language")
        request.setValue("1", forHTTPHeaderField: "Upgrade-Insecure-Requests")
        request.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.setValue("navigate", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.setValue("document", forHTTPHeaderField: "Sec-Fetch-Dest")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 30.0
        webView.load(request)
        
        // Добавляем JavaScript для принудительной загрузки контента
        let contentScript = """
        console.log('=== WebView Content Loader Started ===');
        
        // Глобальные переменные
        let audioContext = null;
        let contentLoaded = false;
        let retryCount = 0;
        const maxRetries = 10;
        
        // Функция для активации аудио
        function activateAudio() {
            try {
                if (!audioContext) {
                    audioContext = new (window.AudioContext || window.webkitAudioContext)();
                }
                if (audioContext.state === 'suspended') {
                    audioContext.resume().then(() => {
                        console.log('Audio context resumed:', audioContext.state);
                    }).catch(e => {
                        console.log('Audio context resume error:', e);
                    });
                }
                console.log('Audio context state:', audioContext.state);
                
                // Принудительно активируем все медиа элементы
                const mediaElements = document.querySelectorAll('video, audio');
                mediaElements.forEach((element, index) => {
                    try {
                        element.muted = false;
                        element.volume = 1.0;
                        element.autoplay = true;
                        element.playsInline = true;
                        element.controls = false;
                        if (element.paused) {
                            element.play().catch(e => console.log('Media play error:', e));
                        }
                    } catch (e) {
                        console.log('Media activation error:', e);
                    }
                });
                
                // Принудительно активируем WebRTC
                if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                    navigator.mediaDevices.getUserMedia({ audio: true, video: false })
                        .then(stream => {
                            console.log('Microphone access granted');
                            // Не останавливаем поток, оставляем его активным
                        })
                        .catch(e => {
                            console.log('Microphone access denied:', e);
                        });
                }
            } catch (e) {
                console.log('Audio context error:', e);
            }
        }
        
        // Функция для принудительной загрузки всех ресурсов
        function forceLoadAllResources() {
            console.log('Force loading all resources...');
            
            // Загружаем все изображения
            const images = document.querySelectorAll('img');
            images.forEach((img, index) => {
                console.log('Processing image', index, ':', img.src, img.complete);
                if (img.src && !img.complete) {
                    console.log('Loading image', index, ':', img.src);
                    img.onload = () => console.log('Image loaded:', img.src);
                    img.onerror = () => console.log('Image failed:', img.src);
                    // Для изображений используем принудительную перезагрузку через src
                    const originalSrc = img.src;
                    img.src = '';
                    setTimeout(() => {
                        img.src = originalSrc;
                    }, 100);
                } else if (img.src) {
                    console.log('Image already loaded:', img.src);
                }
                
                // Принудительно показываем изображения
                img.style.display = 'block';
                img.style.visibility = 'visible';
                img.style.opacity = '1';
            });
            
            // Загружаем все видео
            const videos = document.querySelectorAll('video');
            videos.forEach((video, index) => {
                console.log('Processing video', index, ':', video.src, video.readyState);
                try {
                    video.muted = false;
                    video.volume = 1.0;
                    video.autoplay = true;
                    video.playsInline = true;
                    video.controls = false;
                    video.load();
                    video.play().catch(e => console.log('Video play error:', e));
                } catch (e) {
                    console.log('Video processing error:', e);
                }
            });
            
            // Загружаем все аудио
            const audios = document.querySelectorAll('audio');
            audios.forEach((audio, index) => {
                console.log('Processing audio', index, ':', audio.src, audio.readyState);
                try {
                    audio.muted = false;
                    audio.volume = 1.0;
                    audio.autoplay = true;
                    audio.load();
                    audio.play().catch(e => console.log('Audio play error:', e));
                } catch (e) {
                    console.log('Audio processing error:', e);
                }
            });
            
            // Загружаем все iframe
            const iframes = document.querySelectorAll('iframe');
            iframes.forEach((iframe, index) => {
                console.log('Processing iframe', index, ':', iframe.src);
                if (iframe.src) {
                    iframe.load();
                }
            });
            
            // Принудительно загружаем все canvas
            const canvases = document.querySelectorAll('canvas');
            canvases.forEach((canvas, index) => {
                console.log('Processing canvas', index);
                // Принудительно перерисовываем canvas
                const ctx = canvas.getContext('2d');
                if (ctx) {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                }
            });
            
            // Принудительно загружаем все элементы с фоновыми изображениями
            const elementsWithBg = document.querySelectorAll('[style*="background-image"], [class*="bg"], [class*="background"]');
            elementsWithBg.forEach((element, index) => {
                console.log('Processing background element', index, ':', element.style.backgroundImage);
                // Принудительно перезагружаем фоновое изображение
                const bgImage = element.style.backgroundImage;
                if (bgImage && bgImage !== 'none') {
                    element.style.backgroundImage = 'none';
                    setTimeout(() => {
                        element.style.backgroundImage = bgImage;
                    }, 100);
                }
                
                // Принудительно показываем элементы
                element.style.display = 'block';
                element.style.visibility = 'visible';
                element.style.opacity = '1';
            });
            
            // Принудительно показываем все скрытые элементы
            const hiddenElements = document.querySelectorAll('[style*="display: none"], [style*="visibility: hidden"], [style*="opacity: 0"]');
            hiddenElements.forEach((element, index) => {
                console.log('Showing hidden element', index);
                element.style.display = 'block';
                element.style.visibility = 'visible';
                element.style.opacity = '1';
            });
            
            // Принудительно загружаем все ресурсы через fetch для обхода CORS
            const allElements = document.querySelectorAll('img, video, audio, iframe');
            allElements.forEach((element, index) => {
                if (element.src) {
                    console.log('Fetching resource', index, ':', element.src);
                    fetch(element.src, { mode: 'no-cors' })
                        .then(response => {
                            console.log('Resource fetched:', element.src, response.status);
                        })
                        .catch(error => {
                            console.log('Resource fetch failed:', element.src, error);
                        });
                }
            });
            
            // Принудительно загружаем все скрипты и стили
            const scripts = document.querySelectorAll('script[src]');
            scripts.forEach((script, index) => {
                if (script.src && !script.src.startsWith('data:')) {
                    console.log('Loading script', index, ':', script.src);
                    const newScript = document.createElement('script');
                    newScript.src = script.src;
                    newScript.async = false;
                    newScript.defer = false;
                    document.head.appendChild(newScript);
                }
            });
            
            const styles = document.querySelectorAll('link[rel="stylesheet"]');
            styles.forEach((style, index) => {
                if (style.href && !style.href.startsWith('data:')) {
                    console.log('Loading stylesheet', index, ':', style.href);
                    const newLink = document.createElement('link');
                    newLink.rel = 'stylesheet';
                    newLink.href = style.href;
                    newLink.type = 'text/css';
                    document.head.appendChild(newLink);
                }
            });
        }
        
        // Функция для анализа и принудительной загрузки контента
        function analyzeAndForceLoad() {
            console.log('=== Analyzing content ===');
            
            const allElements = document.querySelectorAll('*');
            const mediaElements = document.querySelectorAll('img, video, audio, iframe, canvas');
            const buttons = document.querySelectorAll('button, [role="button"], .button, .btn, [onclick]');
            const divs = document.querySelectorAll('div');
            const spans = document.querySelectorAll('span');
            
            console.log('Total elements:', allElements.length);
            console.log('Media elements:', mediaElements.length);
            console.log('Found buttons:', buttons.length);
            console.log('Found divs:', divs.length);
            console.log('Found spans:', spans.length);
            console.log('Content length:', document.body.innerHTML.length);
            console.log('Document title:', document.title);
            console.log('Document URL:', window.location.href);
            
            // Принудительно загружаем все ресурсы
            forceLoadAllResources();
            
            // Активируем аудио
            activateAudio();
            
            // Логируем кнопки и добавляем обработчики
            buttons.forEach((btn, index) => {
                console.log('Button', index, ':', btn.textContent, btn.className, btn.id);
                btn.addEventListener('click', function() {
                    console.log('Button clicked:', this.textContent);
                    activateAudio();
                });
            });
            
            // Принудительно показываем все скрытые элементы
            const hiddenElements = document.querySelectorAll('[style*="display: none"], [style*="visibility: hidden"]');
            hiddenElements.forEach((element, index) => {
                console.log('Showing hidden element', index);
                element.style.display = 'block';
                element.style.visibility = 'visible';
            });
            
            // Принудительно загружаем все фоновые изображения
            const elementsWithBg = document.querySelectorAll('[style*="background-image"]');
            elementsWithBg.forEach((element, index) => {
                console.log('Element with background', index, ':', element.style.backgroundImage);
            });
            
            // Проверяем, загрузился ли контент
            if (document.body.innerHTML.length > 1000 || mediaElements.length > 0) {
                console.log('Content appears to be loaded successfully');
                contentLoaded = true;
            } else {
                console.log('Content still not loaded, will retry...');
                if (retryCount < maxRetries) {
                    retryCount++;
                    setTimeout(analyzeAndForceLoad, 1000);
                }
            }
        }
        
        // Функция для принудительной загрузки всех скриптов и стилей
        function forceLoadScriptsAndStyles() {
            console.log('Force loading scripts and styles...');
            
            // Принудительно загружаем все скрипты
            const scripts = document.querySelectorAll('script[src]');
            scripts.forEach((script, index) => {
                if (!script.src.startsWith('data:')) {
                    console.log('Loading script', index, ':', script.src);
                    const newScript = document.createElement('script');
                    newScript.src = script.src;
                    newScript.async = false;
                    newScript.defer = false;
                    document.head.appendChild(newScript);
                }
            });
            
            // Принудительно загружаем все стили
            const links = document.querySelectorAll('link[rel="stylesheet"]');
            links.forEach((link, index) => {
                if (!link.href.startsWith('data:')) {
                    console.log('Loading stylesheet', index, ':', link.href);
                    const newLink = document.createElement('link');
                    newLink.rel = 'stylesheet';
                    newLink.href = link.href;
                    newLink.type = 'text/css';
                    document.head.appendChild(newLink);
                }
            });
            
            // Принудительно загружаем все inline стили
            const styleElements = document.querySelectorAll('style');
            styleElements.forEach((style, index) => {
                console.log('Processing inline style', index);
                // Принудительно перезагружаем inline стили
                const content = style.innerHTML;
                style.innerHTML = '';
                setTimeout(() => {
                    style.innerHTML = content;
                }, 100);
            });
        }
        
        // Основная функция инициализации
        function initializeContent() {
            console.log('Initializing content...');
            
            // Активируем аудио сразу
            activateAudio();
            
            // Принудительно загружаем скрипты и стили
            forceLoadScriptsAndStyles();
            
            // Ждем загрузки DOM
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => {
                    console.log('DOM loaded');
                    setTimeout(analyzeAndForceLoad, 500);
                });
            } else {
                console.log('DOM already loaded');
                setTimeout(analyzeAndForceLoad, 500);
            }
            
            // Также слушаем полную загрузку страницы
            window.addEventListener('load', () => {
                console.log('Window loaded');
                setTimeout(analyzeAndForceLoad, 1000);
            });
            
            // Если через 5 секунд контент не загрузился, перезагружаем
            setTimeout(() => {
                if (!contentLoaded && retryCount >= maxRetries) {
                    console.log('Content failed to load, forcing reload...');
                    window.location.reload();
                }
            }, 5000);
        }
        
        // Запускаем инициализацию
        initializeContent();
        
        // Экспортируем функции для отладки
        window.forceLoadContent = analyzeAndForceLoad;
        window.activateAudio = activateAudio;
        window.forceReload = () => window.location.reload();
        """
        
        let userScript = WKUserScript(source: contentScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(userScript)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Принудительно активируем аудио при каждом обновлении
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            // Игнорируем ошибки аудио сессии
        }
        
        // Принудительно выполняем JavaScript для загрузки контента
        webView.evaluateJavaScript("""
            if (window.forceLoadContent) {
                window.forceLoadContent();
            }
            if (window.activateAudio) {
                window.activateAudio();
            }
        """) { result, error in
            if let error = error {
                // Игнорируем ошибки JavaScript
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebViewWrapper
        
        init(_ parent: WebViewWrapper) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                decisionHandler(.allow)
            } else {
                decisionHandler(.allow)
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // WebView started loading
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // WebView did finish loading
            
            // Проверяем, загрузился ли контент
            webView.evaluateJavaScript("document.body.innerHTML.length") { result, error in
                if let length = result as? Int {
                    // Content length available
                }
            }
            
            // Проверяем, есть ли кнопки на странице
            webView.evaluateJavaScript("document.querySelectorAll('button').length") { result, error in
                if let count = result as? Int {
                    // Button count available
                }
            }
            
            // Проверяем все элементы на странице
            webView.evaluateJavaScript("document.querySelectorAll('*').length") { result, error in
                if let count = result as? Int {
                    // Total elements count available
                }
            }
            
            // Проверяем изображения и видео
            webView.evaluateJavaScript("document.querySelectorAll('img, video, audio').length") { result, error in
                if let count = result as? Int {
                    // Media elements count available
                }
            }
            
            parent.onNavigation(navigation)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // WebView failed to load
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            // WebView failed provisional navigation
        }
    }
}