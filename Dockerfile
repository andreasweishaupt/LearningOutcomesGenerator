FROM node:21 AS build
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt update && apt install -y npm dotnet-sdk-7.0

WORKDIR /app
COPY ["LearningOutcomesGenerator/LearningOutcomesGenerator.csproj", "LearningOutcomesGenerator/"]

RUN dotnet restore "LearningOutcomesGenerator/LearningOutcomesGenerator.csproj"

COPY . .

WORKDIR "/app/LearningOutcomesGenerator"
RUN npm install
RUN dotnet publish "LearningOutcomesGenerator.csproj" -c Release -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=build /app/publish .
CMD ["dotnet", "LearningOutcomesGenerator.dll"]