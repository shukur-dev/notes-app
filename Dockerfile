# Используем официальный образ Node.js для сборки
FROM node:20-alpine AS development

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем остальной исходный код
COPY . .

# Собираем приложение
RUN npm run build

# Продавая стадия (production stage)
FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY package*.json ./

# Устанавливаем только production зависимости
RUN npm install --only=production

# Копируем собранное приложение из development стадии
COPY --from=development /usr/src/app/dist ./dist

# Открываем порт
EXPOSE 3000

# Запускаем приложение
CMD ["node", "dist/main"]