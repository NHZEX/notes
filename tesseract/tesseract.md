## Install Tesseract OCR

```bash
sudo add-apt-repository -y ppa:alex-p/tesseract-ocr5
sudo apt install -y tesseract-ocr
tesseract --version
```

## Use Tesseract OCR

```base
	
wget https://raw.githubusercontent.com/madmaze/pytesseract/master/tests/data/test.png
tesseract test.png stdout
```

## Links

- https://lindevs.com/install-tesseract-ocr-on-ubuntu/

- https://tesseract-ocr.github.io/tessdoc/FAQ.html#running-tesseract

- https://github.com/thiagoalessio/tesseract-ocr-for-php