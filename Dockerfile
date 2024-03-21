FROM node:21 AS build
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt update && apt install -y npm dotnet-sdk-8.0

WORKDIR /app
COPY ["Library/Library.csproj", "Library/"]
COPY ["Server/Server.csproj", "Server/"]

RUN dotnet restore "Server/Server.csproj"

COPY . .

WORKDIR "/app/Library"
RUN npm install
RUN npm run tailwind-build

WORKDIR "/app/Server"
RUN dotnet publish "Server.csproj" -c Release -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=build /app/publish .
CMD ["dotnet", "Server.dll"]