# Use the official .NET SDK image as the base image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project file and restore any dependencies (via 'dotnet restore')
COPY ./*.csproj ./
RUN dotnet restore

# Copy the rest of the code and publish the app
COPY ./. ./
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET Runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Copy the published app from the previous build stage
COPY --from=build /app/publish .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "YourApp.dll"]
