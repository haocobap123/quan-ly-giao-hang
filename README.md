# Hệ thống quản lý giao hàng

Website quản lý giao hàng xây dựng bằng ASP.NET Core 8 (MVC + Web API), MySQL 8 và Entity Framework Core (Pomelo).
Đồ án môn Công nghệ phần mềm nâng cao.

## Công nghệ
ASP.NET Core 8 · MySQL 8 + EF Core (Pomelo) · ASP.NET Core Identity · Bootstrap 5 · Leaflet/OpenStreetMap · SignalR · VNPay Sandbox

## Chạy dự án
1. Cài .NET 8 SDK và MySQL 8.
2. Sửa chuỗi kết nối trong `appsettings.json` (mục `ConnectionStrings`).
3. Tạo CSDL: `dotnet ef database update`
4. Chạy: `dotnet run`

## Quản lý dự án (Scrum trên GitHub)
- Mỗi **Sprint** là một Milestone (14 ngày), 6 sprint, 27 story, 106 điểm.
- Mỗi **story** (PB01-PB27) là một Issue, gán label: `status: New / In progress / Done`, `points: 3 / 5 / 8`, `priority: Must / Should / Could`, `bug`.
- Mỗi tính năng làm trên nhánh `feature/PBxx-ten-ngan`, gộp vào `main` bằng Pull Request có dòng `Solve #<số issue>`.

## Thành viên
- Trần Phương Hạo - Scrum Master, Developer (Fullstack)
