# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

COPY HelloWorldApp.sln ./
COPY HelloWorldApp.web/*.csproj HelloWorldApp.web/

RUN dotnet restore HelloWorldApp.sln

COPY HelloWorldApp.web/ HelloWorldApp.web/

RUN dotnet publish HelloWorldApp.web/HelloWorldApp.web.csproj -c Release -o /app/publish --no-restore

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0 as runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 5004
ENTRYPOINT ["dotnet", "HelloWorldApp.web.dll"]
