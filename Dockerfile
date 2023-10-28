FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copy everything
COPY . /App
# Restore as distinct layers
RUN dotnet restore App/App.fsproj
# Build and publish a release
RUN dotnet publish App -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "App.dll"]
