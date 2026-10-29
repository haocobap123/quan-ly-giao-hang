# Quy trình làm việc

## Trạng thái task (label)
| Label | Ý nghĩa |
|---|---|
| `status: New` | Task mới, chưa làm |
| `status: In progress` | Đang thực hiện |
| `status: Done` | Đã hoàn thành, chờ Scrum Master kiểm tra và đóng |

Ngoài ra: `points: N` (điểm của task), `priority: Must/Should/Could`, `bug` (lỗi).

## Các bước làm một task
1. Đổi label issue sang `status: In progress`.
2. Tạo nhánh từ `main`, đặt tên theo mẫu `feature/PBxx-ten-ngan` (tài liệu: `docs/ten-ngan`).
3. Commit nhỏ, thông điệp bắt đầu bằng mã task, ví dụ `PB01: thêm cấu hình MySQL`.
4. Mở Pull Request vào `main`, ghi `Solve #<số issue>` trong mô tả.
5. Merge Pull Request, đổi label issue sang `status: Done`.
6. Cuối sprint, Scrum Master kiểm tra rồi đóng (Close) các issue Done.

## Định nghĩa hoàn thành (Definition of Done)
- Đạt các tiêu chí chấp nhận ghi trong issue.
- Đã merge vào `main` qua Pull Request.
- Không còn issue `bug` mở liên quan đến task.

## Theo dõi tiến độ
Dùng bộ lọc ở tab Issues, ví dụ: `is:issue milestone:"Sprint 1" label:"status: Done"`.
