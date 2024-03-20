add_header                  X-Frame-Options SAMEORIGIN;
add_header                  X-Content-Type-Options nosniff;
add_header                  X-XSS-Protection "1; mode=block";
add_header                  Content-Security-Policy "default-src 'self'; script-src 'self' https://ssl.google-analytics.com; img-src 'self' https://ssl.google-analytics.com; style-src 'self' https://fonts.googleapis.com; font-src 'self' https://themes.googleusercontent.com; frame-src https://youtube.com; object-src 'none'";
add_header                  Strict-Transport-Security "max-age=31536000; includeSubdomains" always;
add_header                  Referrer-Policy no-referrer-when-downgrade;
add_header                  Feature-Policy "accelerometer 'self'; ambient-light-sensor 'self'; autoplay 'self'; camera 'self'; encrypted-media 'self'; fullscreen 'self'; geolocation 'self'; gyroscope 'self'; magnetometer 'self'; microphone 'self'; midi 'self'; notifications 'self'; payment 'self'; picture-in-picture 'self'; push 'self'; speaker 'self'; sync-xhr 'self'; usb 'self'; vibrate 'self'; vr 'self'";