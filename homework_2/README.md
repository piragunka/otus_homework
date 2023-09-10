<h1 align="center">Nginx - балансировка и отказоустойчивость.</a> 
<img src="https://github.com/blackcater/blackcater/raw/main/images/Hi.gif" height="32"/></h1>

На вашей прекрасной выполняющей машине (с ОС Linux Ubunta 20.04) должны быть выполнены следующие ништяки:

1.   Вы должны иметь учетную записать в Yandex Cloud (видимо с ненулевым балансом, важно т.к. нищим тут не место);
2.   Создано облако и каталог;
3.   Получен API Key Yandex Cloud или IAM tokken с настроенными правами и созданным сервисным аккаунтом;
4.   Установлены terraform, ansible и yc c настроенными переменными окружения;
5.   Создана новая пара ключей для доступа по SSH к развертываемой машине;
6.   VPN или Proxy для инициализации проекта (подключение провайдера), так как зеркало Яндекс недоступно в данный момент;

Что нужно сделать:

1.   Выполнить команду:
```
git clone https://github.com/piragunka/otus_homework
```
2.   В домашнем каталоге пользователя создать файл "terraformrc" следующего содержания:
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
3.   Отредактируйте файл "terraform.tfvars" по чудоинструкции ниже:
```
zone = "ru-central1-c"                 <- туть не трогай уже хорошо
cloud_id = "cloud id"                  <- туть замени на айдишник облака
folder_id = "folder id"                <- туть на айдишник каталога
image_id = "fd8egv6phshj1f64q94n"      <- туть не трогай туть убунта
yc_token = "API Key or IAM tokken"     <- туть выбрать тебе какой ключ сувать
```
4.   Если ты хитрый жук и у тебя несколько сертификатов, поправь пути в файле "main.tf", а то беда будет;
5.   Скачайте архив "https://github.com/adammck/terraform-inventory/releases/download/v0.10/terraform-inventory_v0.10_linux_amd64.zip"
6.   Создайте папку terraform-inventory в каталоге opt и распакуйте в нее выполняющий файл из архива;
7.   Перейти в каталог склонированного проекта и далее в папку "homework_2/terraform";
8.   Включить VPN или Proxy;
9.   Выполнить команду "terraform init";
10.  Выключить VPN или Proxy; (на усмотрение юного пирата);
11.  Выполнить команду "terraform validate"; (умный летописец проверит не обсрамились ли в буквах где)
12.  Выполнить команду "terraform plan";
13.  Выполнить команду "terraform apply" и подтвердить выполнение командой "yes" или кивнуть;
14.  Выполнить команду "TF_STATE=. ansible-playbook --inventory-file=/opt/terraform-inventory ../ansible/main.yml"
15.  В выводе консоли посмотрите публичный ip, он будет единственным, вставьте его в адресную строку браузера "http://<сюда>";
16.  Подпишись на мой телеграмм канал с мемчиками https://t.me/gryazniy_dzho. Без этого наврятли что то хорошее получится;
17.  Печаль. Еле еле это все вкорячил, дальнейший рефакторинг проекта будет в следующих заданиях.
   

