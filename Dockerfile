FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
RUN apt update && apt install -y nodejs npm

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