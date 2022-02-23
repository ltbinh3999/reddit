FROM node:latest
WORKDIR /root
COPY ["package.json", "package-lock.json", "./"]
RUN npm i
COPY . .
EXPOSE 3000
EXPOSE 24678
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]