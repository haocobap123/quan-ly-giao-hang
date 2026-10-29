# Bài thực hành số 3 - Triển khai dự án lên GitHub

Đề tài: Hệ thống quản lý giao hàng. Nhóm 1 người (Trần Phương Hạo). Đề mẫu có David và Ruby; ở đây tên bạn thay cho cả hai.

Bộ file này làm sẵn phần việc lặp lại: tạo label, milestone (sprint) và 27 issue (story). Bạn chỉ cần có tài khoản GitHub, đẩy code lên và chạy một script.

## Nội dung bộ file
| File | Dùng để |
|---|---|
| `setup_github.sh` | Tạo 11 label, 6 milestone Sprint 1-6, 27 issue PB01-PB27 |
| `issues.csv` | Danh sách story/issue để đối chiếu hoặc đưa vào báo cáo |
| `README.md` | README mẫu cho repo |
| `.github/pull_request_template.md` | Mẫu mô tả Pull Request (có dòng `Solve #`) |

## Bước 1. Chuẩn bị
1. Tạo tài khoản GitHub (nếu chưa có).
2. Cài **Git** (https://git-scm.com) và **GitHub CLI** (https://cli.github.com).
3. Mở terminal, chạy `gh auth login` và đăng nhập theo hướng dẫn.

## Bước 2. Tạo repository và đẩy source code
1. Trên GitHub: New repository, đặt tên (ví dụ `quan-ly-giao-hang`), **không** tick "Add a README".
2. Trong thư mục project của bạn, chép `README.md` và thư mục `.github` của bộ file này vào.
3. Tạo `.gitignore` cho .NET: `dotnet new gitignore`
4. Chạy:
```
git init
git add .
git commit -m "Khởi tạo dự án"
git branch -M main
git remote add origin https://github.com/<tai-khoan>/quan-ly-giao-hang.git
git push -u origin main
```
Lưu ý: không đẩy mật khẩu, chuỗi kết nối thật hoặc khóa VNPay lên repo.

## Bước 3. Tạo sprint, label và task (Milestone, Label, Issue)
Trong thư mục bộ file, chạy (Git Bash hoặc WSL trên Windows):
```
./setup_github.sh <tai-khoan>/quan-ly-giao-hang
```
Kết quả:
- **Milestone** = Sprint 1-6, có tiêu đề, mô tả (danh sách story) và hạn (deadline). Ngày theo kế hoạch bài 2 (Sprint 1: 26/10 - 08/11/2026). Muốn đổi ngày, sửa `due_on` trong script hoặc sửa milestone trên web.
- **Label**: trạng thái (New, In progress, Done), điểm (3, 5, 8 - đúng các giá trị trong backlog của bạn), ưu tiên (Must, Should, Could), `bug`, và label người thực hiện.
- **Issue** PB01-PB27 theo thứ tự nên PB01 là `#1`, PB27 là `#27`. Mỗi issue đã gán assignee, milestone, label và có tiêu chí chấp nhận lấy từ backlog.

Script chỉ chạy được trên repo chưa có issue nào. Nếu lỡ chạy sai, xóa repo và tạo lại.

## Bước 4. Làm việc theo từng task
Với mỗi story (ví dụ PB01 = issue `#1`):
1. Đổi label issue từ `status: New` sang `status: In progress`.
2. Tạo nhánh: `git checkout -b feature/PB01-khoi-tao-du-an`
3. Code, commit, đẩy lên: `git push -u origin feature/PB01-khoi-tao-du-an`
4. Tạo **Pull Request** vào `main`. Trong mô tả ghi `Solve #1` để liên kết với issue (mẫu đã có sẵn dòng này). Mở issue `#1` sẽ thấy Pull Request được tham chiếu.
5. Merge Pull Request, đổi label issue sang `status: Done`.
6. Cuối sprint, bạn (Scrum Master) kiểm tra rồi **Close** các issue đã Done.

Nếu muốn GitHub tự đóng issue khi merge, dùng `Closes #1` thay cho `Solve #1`.

## Bước 5. Theo dõi tiến độ bằng filter
Ở tab Issues, dán vào ô tìm kiếm:
- Toàn bộ task Sprint 1: `is:issue milestone:"Sprint 1"`
- Task đang làm: `is:issue milestone:"Sprint 1" label:"status: In progress"`
- Task đã xong: `is:issue milestone:"Sprint 1" label:"status: Done"`
- Task Must chưa xong: `is:issue is:open label:"priority: Must"`
- Lỗi: `is:issue label:bug`

Tab Milestones hiện phần trăm hoàn thành của từng sprint.

## Ảnh chụp màn hình nên đưa vào báo cáo
1. Trang Milestones (6 sprint, có deadline và mô tả).
2. Trang Labels.
3. Danh sách Issues với label và milestone.
4. Chi tiết một issue (ví dụ `#1`: assignee, label, milestone).
5. Pull Request có dòng `Solve #1` và issue hiển thị Pull Request được tham chiếu.
6. Kết quả filter theo Sprint 1 và label trạng thái.
7. Link repository.

## Chưa kiểm tra
Mình không có quyền vào GitHub của bạn nên chưa chạy script trên GitHub thật, chỉ kiểm tra cú pháp bash. Nếu script báo lỗi, gửi mình dòng lỗi để sửa. Nếu không dùng được `gh`, bạn có thể tạo thủ công theo `issues.csv`.
