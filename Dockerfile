# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy csproj and restore
COPY SampleWebApp/*.csproj ./
RUN dotnet restore

# Copy source and publish
COPY SampleWebApp/. ./
RUN dotnet publish -c Release -o /WebApp --no-restore

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /WebApp
COPY --from=build /WebApp ./

EXPOSE 5004
CMD ["dotnet", "SampleWebApp.dll"]
