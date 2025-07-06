FROM node:18

# Set working directory
WORKDIR /app

# Copy dependencies file
COPY package.json ./
RUN npm install

# Copy app code
COPY . .

# Jalankan aplikasi
CMD ["npm", "start"]
