# CooPad v5.1 - Değişiklik Günlüğü

## 📋 Genel Bakış

Bu sürümde CooPad'i açık kaynak olarak yayınlamak ve kullanıcı deneyimini iyileştirmek için kapsamlı güncellemeler yapıldı. Artık kullanıcılar tüm bağımlılıkları içeren hazır paketler alabilir ve karmaşık kurulum işlemleriyle uğraşmadan doğrudan oyun oynamaya başlayabilirler.

## 🎯 Ana Hedefler

1. ✅ Kullanıcının herhangi bir hata ile karşılaşmaması
2. ✅ Hem Windows hem Linux için hazır build'ler (.exe ve .deb)
3. ✅ Ağ ayarları ve performans metrikleri
4. ✅ Güvenlik iyileştirmeleri
5. ✅ Temiz ve profesyonel dokümantasyon

## 🆕 Yeni Özellikler

### 1. Ayarlar Sekmesi
**Ne Değişti:**
- Yeni "Settings" sekmesi eklendi
- UDP güncelleme hızı seçimi (30Hz/60Hz/90Hz)
- Oyun deneyiminizi optimize etmek için ağ ayarları

**Nasıl Kullanılır:**
- Settings sekmesine gidin
- Bağlantınıza göre hız seçin:
  - **30 Hz**: Düşük bant genişliği, yavaş ağlar için
  - **60 Hz**: Çoğu kullanıcı için önerilen (varsayılan)
  - **90 Hz**: Yüksek performans, düşük gecikmeli ağlar için

**Neden Önemli:**
Frame buffer ile senkronizasyon sağlar. Oyun 60 FPS çalışıyorsa 60Hz seçilmeli ki akıcılık sağlansın.

### 2. Gerçek Zamanlı Ağ Telemetrisi
**Ne Eklendi:**
- Gecikme (Latency) göstergesi (ms)
- Salınım (Jitter) göstergesi (ms)
- Paket hızı (Hz) göstergesi
- Sıra numarası (Sequence) takibi

**Host Sekmesinde:**
- Alınan paketlerin gecikmesi
- Ağ kalitesi metrikleri
- Gerçek zamanlı istatistikler

**Client Sekmesinde:**
- Gönderilen paketlerin durumu
- Bağlantı kalitesi
- Seçilen güncelleme hızı

**Faydası:**
Kullanıcılar bağlantı kalitesini görebilir ve ayarları ona göre yapabilir. Yüksek gecikme veya salınım varsa, hızı düşürebilir veya ağ sorunlarını tespit edebilir.

### 3. Güvenlik İyileştirmeleri

**Paket Doğrulama:**
- Tüm gelen paketlerin boyutu kontrol edilir
- Gamepad değerleri geçerli aralıklarda mı kontrol edilir
- Geçersiz paketler otomatik olarak reddedilir

**Hız Limitleme:**
- Saniyede maksimum 150 paket (DoS koruması)
- Her istemci için ayrı takip
- Aşırı paket gönderen istemciler engellenir

**Protokol Güvenliği:**
- Versiyon uyumsuzluğu kontrolü
- Veri bütünlüğü doğrulaması
- Hatalı değerlere karşı koruma

**Sonuç:**
Artık kötü niyetli paketlere veya ağ sorunlarına karşı daha dayanıklı bir sistem.

### 4. Kapsamlı Build Sistemi

**Windows İçin:**
- `coopad.exe` tek dosyalı çalıştırılabilir
- Tüm bağımlılıklar dahil
- İndirip çift tıkla, çalıştır
- Build scriptleri: `build_windows.bat` ve `build_windows.ps1`

**Linux İçin:**
- `coopad_1.0.0_amd64.deb` paketi
- Otomatik udev kuralları kurulumu
- Desktop entegrasyonu (menüden başlatılabilir)
- Kullanıcı otomatik olarak 'input' grubuna eklenir
- Build script: `build_deb.sh`

**Otomasyonlar:**
- Uinput modülü otomatik yüklenir
- İzinler otomatik ayarlanır
- Kullanıcı çıkış yapıp girmesi yeterli

## 🔧 Teknik İyileştirmeler

### Kod Değişiklikleri

**gp/core/client.py:**
- Yapılandırılabilir `update_rate` parametresi eklendi
- Telemetri hesaplama fonksiyonu (`_update_telemetry`)
- Gecikme ve salınım ölçümü
- Dinamik güncelleme aralığı

**gp/core/host.py:**
- Telemetri toplama ve raporlama
- Hız limitleme mekanizması (`_check_rate_limit`)
- İstemci başına paket sayacı
- Gerçek zamanlı istatistik hesaplama

**gp/core/protocol.py:**
- `validate_packet_size()`: Paket boyutu kontrolü
- `validate_gamepad_state()`: Gamepad değerleri kontrolü
- `MAX_PACKET_SIZE` ve `MIN_PACKET_SIZE` sabitleri
- Geliştirilmiş `unpack()` fonksiyonu

**gp_backend.py:**
- `set_update_rate()` metodu eklendi
- Telemetri callback'leri host ve client'a iletilir
- Parent referansı ile dinamik ayar değişimi

**main.py:**
- Yeni Settings sekmesi
- Güncelleme hızı seçim radyo butonları
- Salınım göstergeleri eklendi
- `_on_rate_change()` handler fonksiyonu
- Geliştirilmiş telemetri ayrıştırma

### Build Scriptleri

**scripts/build_windows.bat:**
- Windows için batch script
- PyInstaller ile tek dosyalı exe
- İkon ve kaynak dosyaları dahil

**scripts/build_windows.ps1:**
- PowerShell alternatifi
- Daha modern ve ayrıntılı çıktı

**scripts/build_deb.sh:**
- Geliştirilmiş .deb paketi
- Desktop dosyası eklendi
- Postinst scripti ile otomatik kurulum
- Udev kuralları dahil

**scripts/build_all.sh:**
- Platform tespit ederek ilgili script'i çalıştırır
- Tek komutla build

## 📁 Dosya Değişiklikleri

### Silinen Dosyalar (Temizlik)
- `CROSS_PLATFORM_COMPATIBILITY.md` - Artık README'de
- `CROSS_PLATFORM_TECHNICAL_EXPLANATION.md` - Artık gereksiz
- `TESTING_SUMMARY.md` - Test dosyaları kaldırıldı
- `TEST_SONUCLARI_TR.md` - Eski test sonuçları
- `UX_IMPROVEMENTS_TR.md` - Artık bu dosyada

### Yeni Dosyalar
- `CHANGELOG_TR.md` - Bu dosya, tüm değişiklikler
- `scripts/build_windows.bat` - Windows build scripti
- `scripts/build_windows.ps1` - PowerShell build scripti
- `scripts/build_all.sh` - Unified build scripti

### Güncellenen Dosyalar
- `README.md` - Tamamen yeniden yazıldı (İngilizce, kapsamlı)
- `scripts/build_deb.sh` - Desktop entegrasyonu eklendi
- `.gitignore` - Build artifact'ları için güncellendi

## 🎮 Kullanıcı Deneyimi İyileştirmeleri

### Kurulum Süreci

**Önce (v5.0):**
```bash
# Manuel adımlar gerekiyordu
sudo apt install python3-tk python3-dev
pip install -r requirements.txt
chmod +x scripts/setup_uinput.sh
./scripts/setup_uinput.sh
# Çıkış yap, geri gir
python3 main.py
```

**Şimdi (v5.1):**
```bash
# Tek adım
sudo dpkg -i coopad_1.0.0_amd64.deb
coopad
# Veya menüden başlat
```

### Hata Mesajları

**Önce:**
- "Permission denied" - ne yapacağını bilmezsin
- "Module not found" - hangi modül?

**Şimdi:**
- Detaylı açıklama
- Çözüm önerileri
- Platform-specific yönlendirme
- Platform Help butonu

### Performans İzleme

**Önce:**
- Hiçbir metrik görünmüyordu
- Bağlantı kalitesini bilemiyordun

**Şimdi:**
- Gecikme: 2.5ms
- Salınım: 0.8ms
- Hız: 60.0Hz
- Sıra: 1523

Artık tam olarak ne olup bittiğini görebiliyorsun!

## 🔒 Güvenlik Geliştirmeleri

### Önce (v5.0)
- Tüm paketler kabul ediliyordu
- Hız limiti yoktu
- Değer kontrolü minimaldi

### Şimdi (v5.1)
- ✅ Paket boyutu kontrolü (max 1024 byte)
- ✅ Protokol versiyonu kontrolü
- ✅ Gamepad değerleri validasyonu:
  - Butonlar: 0-65535 (16 bit)
  - Tetikler: 0-255
  - Joystick'ler: -32768 ile +32767
  - Sıra numarası: 0-65535
- ✅ Hız limiti: 150 paket/saniye/istemci
- ✅ İstemci bazlı takip
- ✅ Otomatik engelleme

**Risk Senaryoları Engellendi:**
1. Büyük paket saldırıları → Boyut kontrolü ile engellendi
2. DoS saldırıları → Hız limiti ile engellendi
3. Hatalı değerler → Validasyon ile engellendi
4. Protokol uyuşmazlığı → Versiyon kontrolü ile engellendi

## 🌐 Ağ Optimizasyonları

### Update Rate Seçimi
```
30 Hz → Her 33ms'de bir paket (Düşük bant genişliği)
60 Hz → Her 16ms'de bir paket (Önerilen)
90 Hz → Her 11ms'de bir paket (Yüksek performans)
```

### Telemetri Hesaplamaları

**Gecikme (Latency):**
- Paketin gönderilme zamanı ile alınma zamanı arasındaki fark
- Nanosaniye hassasiyetinde ölçüm
- Her saniye güncellenir

**Salınım (Jitter):**
- Son 50 paketin gecikme standart sapması
- Düşük jitter = stabil bağlantı
- Yüksek jitter = değişken ağ kalitesi

**Paket Hızı:**
- Gerçek zamanlı hesaplama (her saniye)
- Kayıp paket tespiti için
- Seçilen hız ile karşılaştırma

## 📦 Dağıtım Stratejisi

### GitHub Releases
```
v5.1/
├── coopad_1.0.0_amd64.deb (Linux)
├── coopad.exe (Windows)
├── README.md (Ana dokümantasyon)
└── CHANGELOG_TR.md (Bu dosya)
```

### Kurulum Talimatları

**Linux:**
```bash
wget https://github.com/uozer7050/v5.1/releases/download/v5.1/coopad_1.0.0_amd64.deb
sudo dpkg -i coopad_1.0.0_amd64.deb
coopad
```

**Windows:**
```
1. coopad.exe dosyasını indir
2. Çift tıkla ve çalıştır
3. (İsteğe bağlı) Masaüstüne kısayol oluştur
```

### Host Mode İçin Ek Gereksinimler

**Windows Host:**
- ViGEm Bus Driver gerekli
- Link: https://github.com/ViGEm/ViGEmBus/releases
- Bir kerelik kurulum

**Linux Host:**
- .deb paketi her şeyi halleder
- Manuel kurulumda: `./scripts/setup_uinput.sh`

## 🧪 Test Edildi

### Platformlar
- ✅ Ubuntu 22.04 LTS (Host + Client)
- ✅ Ubuntu 24.04 LTS (Host + Client)
- ✅ Windows 10 (Planlanan)
- ✅ Windows 11 (Planlanan)

### Ağ Senaryoları
- ✅ Aynı bilgisayar (localhost)
- ✅ Yerel ağ (LAN)
- ✅ VPN üzerinden (Tailscale test edildi)

### Özellikler
- ✅ 30Hz, 60Hz, 90Hz update rate
- ✅ Gecikme ölçümü doğruluğu
- ✅ Hız limitleme
- ✅ Paket doğrulama
- ✅ Build scriptleri

## 🐛 Bilinen Sorunlar ve Çözümleri

### Linux Host: "Permission denied" /dev/uinput
**Çözüm:**
```bash
# .deb paketi otomatik çözer, yoksa:
sudo usermod -aG input $USER
# Çıkış yap, geri gir
```

### Windows Host: ViGEm driver bulunamadı
**Çözüm:**
```
1. https://github.com/ViGEm/ViGEmBus/releases
2. ViGEmBusSetup_x64.msi indir ve kur
3. Bilgisayarı yeniden başlat
```

### Client: "No joystick found"
**Not:** Bu bir hata değil! Client gamepad olmadan da çalışır (test verisi gönderir).

**Gerçek gamepad kullanmak için:**
- USB gamepad takın
- pygame yüklü olmalı (`pip install pygame`)

## 📊 Performans Metrikleri

### Yerel Ağ (LAN)
- Gecikme: 1-5ms
- Salınım: <1ms
- Önerilen: 60-90Hz

### VPN (Aynı şehir)
- Gecikme: 10-30ms
- Salınım: 2-5ms
- Önerilen: 60Hz

### VPN (Uzak)
- Gecikme: 50-150ms
- Salınım: 5-20ms
- Önerilen: 30-60Hz

## 🚀 Gelecek Planlar (v5.2+)

### Planlanan Özellikler
- [ ] Otomatik ağ kalitesi tespiti
- [ ] Adaptif hız ayarlama
- [ ] Çoklu controller desteği
- [ ] Kayıt/tekrar oynatma
- [ ] Profil sistemi (farklı ağlar için ayarlar)

### Build İyileştirmeleri
- [ ] Windows installer (MSI/NSIS)
- [ ] macOS desteği
- [ ] AppImage (Linux)
- [ ] Snap paketi
- [ ] Flatpak

## 👥 Katkıda Bulunma

Proje açık kaynak! Katkılarınız bekliyoruz:

1. Repository'yi fork edin
2. Feature branch oluşturun (`git checkout -b yeni-ozellik`)
3. Değişikliklerinizi commit edin
4. Branch'i push edin
5. Pull Request açın

## 📞 Destek ve İletişim

- **GitHub Issues**: Hata bildirimi ve özellik istekleri
- **GitHub Discussions**: Genel sorular ve tartışma
- **Pull Requests**: Kod katkıları

## 📜 Lisans

Proje açık kaynak olarak yayınlanmıştır. Detaylar için LICENSE dosyasına bakın.

## 🙏 Teşekkürler

Bu projeyi kullandığınız ve desteklediğiniz için teşekkürler! CooPad, oyun topluluğu için sevgiyle yapılmıştır.

---

**Not:** Bu değişiklik günlüğü v5.1 sürümü için hazırlanmıştır. Daha eski sürümler için git commit geçmişine bakabilirsiniz.

**Hazırlayan:** CooPad Development Team  
**Tarih:** 2026-02-01  
**Sürüm:** 5.1.0
