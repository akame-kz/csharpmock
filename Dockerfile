FROM mcr.microsoft.com/dotnet/sdk:8.0 AS buildStep
WORKDIR /source

COPY *.sln .
COPY MockApiService/*.csproj ./MockApiService/
RUN dotnet restore

COPY MockApiService/. ./MockApiService/
WORKDIR /source/MockApiService
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "aspnetadd.dll"]