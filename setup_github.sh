#!/usr/bin/env bash
# Thiết lập GitHub cho đồ án: Hệ thống quản lý giao hàng (Bài thực hành số 3)
# Tạo: 11 label, 6 milestone (= 6 sprint), 27 issue (= 27 story PB01-PB27).
# Cách dùng:  ./setup_github.sh <tai-khoan>/<ten-repo>     (cần: gh auth login)
# Chỉ chạy MỘT lần trên repo mới, chưa có issue nào.
set -euo pipefail
REPO="${1:?Cách dùng: ./setup_github.sh <tai-khoan>/<ten-repo>}"
command -v gh >/dev/null || { echo "Chưa cài GitHub CLI (gh): https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Chưa đăng nhập: chạy 'gh auth login' trước"; exit 1; }
if [ "$(gh issue list --repo "$REPO" --state all --limit 1 --json number --jq length)" != "0" ]; then
  echo "Repo đã có issue. Script chỉ dùng cho repo mới để số issue khớp PB01=#1 ... PB27=#27."; exit 1
fi

echo "== Tạo label =="
gh label create "status: New" --repo "$REPO" --color 0E8A16 --description "Task mới, chưa làm" --force
gh label create "status: In progress" --repo "$REPO" --color FBCA04 --description "Task đang thực hiện" --force
gh label create "status: Done" --repo "$REPO" --color 5319E7 --description "Task đã hoàn thành" --force
gh label create "bug" --repo "$REPO" --color D73A4A --description "Lỗi cần sửa" --force
gh label create "points: 3" --repo "$REPO" --color BFD4F2 --description "Story 3 điểm" --force
gh label create "points: 5" --repo "$REPO" --color 7FB2E5 --description "Story 5 điểm" --force
gh label create "points: 8" --repo "$REPO" --color 1D76DB --description "Story 8 điểm" --force
gh label create "priority: Must" --repo "$REPO" --color B60205 --description "Ưu tiên Must" --force
gh label create "priority: Should" --repo "$REPO" --color D93F0B --description "Ưu tiên Should" --force
gh label create "priority: Could" --repo "$REPO" --color FEF2C0 --description "Ưu tiên Could" --force
gh label create "dev: Trần Phương Hạo" --repo "$REPO" --color C5DEF5 --description "Người thực hiện" --force

echo "== Tạo milestone (sprint) =="
DESC=$(cat <<'EOF_MS1'
Sprint 1: 26/10/2026 - 08/11/2026 (14 ngày), 3 story, 13 điểm.

- PB01 (5 điểm): Khởi tạo dự án .NET 8 + MySQL
- PB02 (5 điểm): Đăng nhập và phân quyền theo vai trò
- PB03 (3 điểm): Quản lý tài khoản nhân viên
EOF_MS1
)
gh api "repos/$REPO/milestones" -f title="Sprint 1" -f state=open -f description="$DESC" -f due_on="2026-11-08T23:59:59Z" --silent
DESC=$(cat <<'EOF_MS2'
Sprint 2: 09/11/2026 - 22/11/2026 (14 ngày), 5 story, 19 điểm.

- PB04 (5 điểm): Nhận mã đơn hàng từ website bán hàng (API)
- PB05 (3 điểm): Gửi yêu cầu giao hàng đến nhận hàng từ công ty
- PB06 (3 điểm): Cập nhật trạng thái đơn hàng tuần tự
- PB07 (3 điểm): Quản lý bảng báo giá
- PB08 (5 điểm): Kiểm tra hàng hóa
EOF_MS2
)
gh api "repos/$REPO/milestones" -f title="Sprint 2" -f state=open -f description="$DESC" -f due_on="2026-11-22T23:59:59Z" --silent
DESC=$(cat <<'EOF_MS3'
Sprint 3: 23/11/2026 - 06/12/2026 (14 ngày), 6 story, 20 điểm.

- PB09 (3 điểm): Đề xuất, chọn phương tiện giao hàng
- PB10 (3 điểm): Đưa ra mức giá theo bảng báo giá
- PB11 (3 điểm): Nhập thông tin gói hàng
- PB12 (3 điểm): Khai báo thông số kèm theo
- PB15 (3 điểm): Quản lý danh mục loại hàng, tuyến xe, phương tiện
- PB16 (5 điểm): Phân loại hàng hóa theo kích cỡ và tuyến xe
EOF_MS3
)
gh api "repos/$REPO/milestones" -f title="Sprint 3" -f state=open -f description="$DESC" -f due_on="2026-12-06T23:59:59Z" --silent
DESC=$(cat <<'EOF_MS4'
Sprint 4: 07/12/2026 - 20/12/2026 (14 ngày), 5 story, 19 điểm.

- PB13 (3 điểm): Nhận tiền gửi thường (thu khi giao hàng)
- PB14 (5 điểm): Nhận tiền gửi nhanh (chuyển khoản/trực tuyến)
- PB17 (3 điểm): Phân công nhân viên giao hàng
- PB18 (5 điểm): Giao hàng thường
- PB23 (3 điểm): Lập phiếu giao hàng
EOF_MS4
)
gh api "repos/$REPO/milestones" -f title="Sprint 4" -f state=open -f description="$DESC" -f due_on="2026-12-20T23:59:59Z" --silent
DESC=$(cat <<'EOF_MS5'
Sprint 5: 21/12/2026 - 03/01/2027 (14 ngày), 3 story, 18 điểm.

- PB19 (5 điểm): Giao hàng nhanh
- PB20 (5 điểm): Cài đặt điểm check-in trên bản đồ
- PB21 (8 điểm): Tự động check-in khi qua điểm đã cài đặt
EOF_MS5
)
gh api "repos/$REPO/milestones" -f title="Sprint 5" -f state=open -f description="$DESC" -f due_on="2027-01-03T23:59:59Z" --silent
DESC=$(cat <<'EOF_MS6'
Sprint 6: 04/01/2027 - 17/01/2027 (14 ngày), 5 story, 17 điểm.

- PB22 (5 điểm): Khách hàng theo dõi hành trình đơn hàng
- PB24 (3 điểm): Giao tận nơi, xác nhận đã giao theo phiếu
- PB25 (3 điểm): Báo giao thất bại và hoàn hàng
- PB26 (3 điểm): Tra cứu đơn hàng
- PB27 (3 điểm): Báo cáo thống kê
EOF_MS6
)
gh api "repos/$REPO/milestones" -f title="Sprint 6" -f state=open -f description="$DESC" -f due_on="2027-01-17T23:59:59Z" --silent

echo "== Tạo issue (mỗi story = 1 issue) =="
BODY=$(cat <<'EOF_PB01'
**User story:** Khởi tạo dự án .NET 8 + MySQL
**Nhóm chức năng:** 1. Nền tảng hệ thống
**Sprint:** 1   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
dotnet run chạy được; migration tạo CSDL MySQL (Pomelo); có README hướng dẫn chạy

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB01
)
gh issue create --repo "$REPO" --title "PB01 - Khởi tạo dự án .NET 8 + MySQL" --body "$BODY" --milestone "Sprint 1" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB02'
**User story:** Đăng nhập và phân quyền theo vai trò
**Nhóm chức năng:** 1. Nền tảng hệ thống
**Sprint:** 1   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
ASP.NET Core Identity; seed 4 vai trò + tài khoản mẫu; vào trang không đủ quyền bị chặn

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB02
)
gh issue create --repo "$REPO" --title "PB02 - Đăng nhập và phân quyền theo vai trò" --body "$BODY" --milestone "Sprint 1" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB03'
**User story:** Quản lý tài khoản nhân viên
**Nhóm chức năng:** 1. Nền tảng hệ thống
**Sprint:** 1   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Admin thêm/sửa/khóa tài khoản; không cho tự khóa chính mình

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB03
)
gh issue create --repo "$REPO" --title "PB03 - Quản lý tài khoản nhân viên" --body "$BODY" --milestone "Sprint 1" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB04'
**User story:** Nhận mã đơn hàng từ website bán hàng (API)
**Nhóm chức năng:** 2. Nhận mã đơn hàng
**Sprint:** 2   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
POST /api/orders + API key; mã trùng/sai trả lỗi; đơn mới ở trạng thái Chưa nhận; test bằng Postman

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB04
)
gh issue create --repo "$REPO" --title "PB04 - Nhận mã đơn hàng từ website bán hàng (API)" --body "$BODY" --milestone "Sprint 2" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB05'
**User story:** Gửi yêu cầu giao hàng đến nhận hàng từ công ty
**Nhóm chức năng:** 2. Nhận mã đơn hàng
**Sprint:** 2   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Danh sách đơn Chưa nhận; chọn nhân viên đi lấy; lưu thời điểm và người gửi yêu cầu

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB05
)
gh issue create --repo "$REPO" --title "PB05 - Gửi yêu cầu giao hàng đến nhận hàng từ công ty" --body "$BODY" --milestone "Sprint 2" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB06'
**User story:** Cập nhật trạng thái đơn hàng tuần tự
**Nhóm chức năng:** 3. Cập nhật trạng thái đơn hàng
**Sprint:** 2   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Không nhảy cóc/lùi trạng thái; lưu lịch sử người đổi, thời gian; dùng chung cho các story sau

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB06
)
gh issue create --repo "$REPO" --title "PB06 - Cập nhật trạng thái đơn hàng tuần tự" --body "$BODY" --milestone "Sprint 2" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB07'
**User story:** Quản lý bảng báo giá
**Nhóm chức năng:** 4. Nhận hàng hóa từ công ty - Kiểm tra hàng và báo giá
**Sprint:** 2   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Thêm/sửa/ẩn dòng giá; khoảng giá không chồng lấn; có ngày áp dụng

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB07
)
gh issue create --repo "$REPO" --title "PB07 - Quản lý bảng báo giá" --body "$BODY" --milestone "Sprint 2" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB08'
**User story:** Kiểm tra hàng hóa
**Nhóm chức năng:** 4. Nhận hàng hóa từ công ty - Kiểm tra hàng và báo giá
**Sprint:** 2   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Căn cứ chọn phương tiện và mức giá; validate số > 0; chỉ nhập cho đơn đã có yêu cầu lấy hàng

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB08
)
gh issue create --repo "$REPO" --title "PB08 - Kiểm tra hàng hóa" --body "$BODY" --milestone "Sprint 2" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB09'
**User story:** Đề xuất, chọn phương tiện giao hàng
**Nhóm chức năng:** 4. Nhận hàng hóa từ công ty - Kiểm tra hàng và báo giá
**Sprint:** 3   |   **Điểm:** 3   |   **Ưu tiên:** Should

### Tiêu chí chấp nhận
Gợi ý theo trọng lượng, kích thước, khoảng cách; cho đổi thủ công; dùng danh mục PB15

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB09
)
gh issue create --repo "$REPO" --title "PB09 - Đề xuất, chọn phương tiện giao hàng" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Should" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB10'
**User story:** Đưa ra mức giá theo bảng báo giá
**Nhóm chức năng:** 4. Nhận hàng hóa từ công ty - Kiểm tra hàng và báo giá
**Sprint:** 3   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Tự tính giá từ đặc điểm hàng; hiển thị chi tiết phí; báo lỗi khi không có dòng giá phù hợp

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB10
)
gh issue create --repo "$REPO" --title "PB10 - Đưa ra mức giá theo bảng báo giá" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB11'
**User story:** Nhập thông tin gói hàng
**Nhóm chức năng:** 5. Nhận hàng hóa từ công ty - Nhập thông tin gói hàng
**Sprint:** 3   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
SĐT đúng định dạng VN (10 số); mã hàng khớp mã đơn; lưu xong chuyển Đã nhận - Chưa giao

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB11
)
gh issue create --repo "$REPO" --title "PB11 - Nhập thông tin gói hàng" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB12'
**User story:** Khai báo thông số kèm theo
**Nhóm chức năng:** 5. Nhận hàng hóa từ công ty - Nhập thông tin gói hàng
**Sprint:** 3   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Chọn Thu tiền thì bắt buộc nhập số tiền > 0; hàng dễ vỡ/trị giá ghi nhận riêng

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB12
)
gh issue create --repo "$REPO" --title "PB12 - Khai báo thông số kèm theo" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB15'
**User story:** Quản lý danh mục loại hàng, tuyến xe, phương tiện
**Nhóm chức năng:** 7. Phân loại hàng
**Sprint:** 3   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Loại hàng: gói nhỏ, bọc van, bọc, bao, thùng, bao PB, hộp thùng, tivi, laptop, CPU, xe...

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB15
)
gh issue create --repo "$REPO" --title "PB15 - Quản lý danh mục loại hàng, tuyến xe, phương tiện" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB16'
**User story:** Phân loại hàng hóa theo kích cỡ và tuyến xe
**Nhóm chức năng:** 7. Phân loại hàng
**Sprint:** 3   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Gán loại hàng + tuyến xe; gợi ý theo kích thước; danh sách gói theo tuyến xe

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB16
)
gh issue create --repo "$REPO" --title "PB16 - Phân loại hàng hóa theo kích cỡ và tuyến xe" --body "$BODY" --milestone "Sprint 3" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB13'
**User story:** Nhận tiền gửi thường (thu khi giao hàng)
**Nhóm chức năng:** 6. Nhận hàng hóa từ công ty - Nhận tiền
**Sprint:** 4   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Chỉ áp dụng gửi thường; nhập số tiền thực thu, đối chiếu số cần thu

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB13
)
gh issue create --repo "$REPO" --title "PB13 - Nhận tiền gửi thường (thu khi giao hàng)" --body "$BODY" --milestone "Sprint 4" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB14'
**User story:** Nhận tiền gửi nhanh (chuyển khoản/trực tuyến)
**Nhóm chức năng:** 6. Nhận hàng hóa từ công ty - Nhận tiền
**Sprint:** 4   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
VNPay Sandbox hoặc giả lập; xác thực chữ ký callback; chưa thanh toán không được xuất giao

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB14
)
gh issue create --repo "$REPO" --title "PB14 - Nhận tiền gửi nhanh (chuyển khoản/trực tuyến)" --body "$BODY" --milestone "Sprint 4" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB17'
**User story:** Phân công nhân viên giao hàng
**Nhóm chức năng:** 8. Giao hàng
**Sprint:** 4   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Chọn nhân viên giao hàng; nhân viên thấy đơn được giao trên điện thoại; lưu lịch sử phân công

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB17
)
gh issue create --repo "$REPO" --title "PB17 - Phân công nhân viên giao hàng" --body "$BODY" --milestone "Sprint 4" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB18'
**User story:** Giao hàng thường
**Nhóm chức năng:** 8. Giao hàng
**Sprint:** 4   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Gom đơn cùng tuyến vào 1 chuyến; khi xuất phát chuyển Đã nhận - Đang giao

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB18
)
gh issue create --repo "$REPO" --title "PB18 - Giao hàng thường" --body "$BODY" --milestone "Sprint 4" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB23'
**User story:** Lập phiếu giao hàng
**Nhóm chức năng:** 10. Trả hàng cho khách
**Sprint:** 4   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Phiếu có mã, địa chỉ, phường/xã, SĐT, tiền thu, cờ dễ vỡ/trị giá; in được

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB23
)
gh issue create --repo "$REPO" --title "PB23 - Lập phiếu giao hàng" --body "$BODY" --milestone "Sprint 4" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB19'
**User story:** Giao hàng nhanh
**Nhóm chức năng:** 8. Giao hàng
**Sprint:** 5   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Mỗi đơn 1 chuyến riêng; phụ phí nhanh từ bảng giá; phải thanh toán (PB14) trước khi xuất phát

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB19
)
gh issue create --repo "$REPO" --title "PB19 - Giao hàng nhanh" --body "$BODY" --milestone "Sprint 5" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB20'
**User story:** Cài đặt điểm check-in trên bản đồ
**Nhóm chức năng:** 9. Module check-in vị trí khi giao hàng
**Sprint:** 5   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Leaflet + OpenStreetMap; lưu vĩ độ, kinh độ, bán kính mặc định 100 m; gắn điểm vào tuyến

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB20
)
gh issue create --repo "$REPO" --title "PB20 - Cài đặt điểm check-in trên bản đồ" --body "$BODY" --milestone "Sprint 5" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB21'
**User story:** Tự động check-in khi qua điểm đã cài đặt
**Nhóm chức năng:** 9. Module check-in vị trí khi giao hàng
**Sprint:** 5   |   **Điểm:** 8   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Geolocation API (HTTPS) + Haversine; 1 lần/điểm/chuyến; hạn chế: phải mở trang, không chạy nền

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB21
)
gh issue create --repo "$REPO" --title "PB21 - Tự động check-in khi qua điểm đã cài đặt" --body "$BODY" --milestone "Sprint 5" --assignee "@me" --label "status: New" --label "points: 8" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB22'
**User story:** Khách hàng theo dõi hành trình đơn hàng
**Nhóm chức năng:** 9. Module check-in vị trí khi giao hàng
**Sprint:** 6   |   **Điểm:** 5   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Nhập mã đơn + SĐT; timeline check-in + bản đồ; cập nhật bằng SignalR

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB22
)
gh issue create --repo "$REPO" --title "PB22 - Khách hàng theo dõi hành trình đơn hàng" --body "$BODY" --milestone "Sprint 6" --assignee "@me" --label "status: New" --label "points: 5" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB24'
**User story:** Giao tận nơi, xác nhận đã giao theo phiếu
**Nhóm chức năng:** 10. Trả hàng cho khách
**Sprint:** 6   |   **Điểm:** 3   |   **Ưu tiên:** Must

### Tiêu chí chấp nhận
Bấm Đã giao (ghi thời gian, vị trí); có thu tiền thì hoàn tất PB13 trước; đơn chuyển Đã giao

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB24
)
gh issue create --repo "$REPO" --title "PB24 - Giao tận nơi, xác nhận đã giao theo phiếu" --body "$BODY" --milestone "Sprint 6" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Must" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB25'
**User story:** Báo giao thất bại và hoàn hàng
**Nhóm chức năng:** 10. Trả hàng cho khách
**Sprint:** 6   |   **Điểm:** 3   |   **Ưu tiên:** Could

### Tiêu chí chấp nhận
Ngoài 4 trạng thái của đề, cần hỏi giảng viên trước khi làm

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB25
)
gh issue create --repo "$REPO" --title "PB25 - Báo giao thất bại và hoàn hàng" --body "$BODY" --milestone "Sprint 6" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Could" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB26'
**User story:** Tra cứu đơn hàng
**Nhóm chức năng:** 11. Tra cứu và báo cáo
**Sprint:** 6   |   **Điểm:** 3   |   **Ưu tiên:** Should

### Tiêu chí chấp nhận
Lọc kết hợp nhiều tiêu chí; phân trang; xem lịch sử trạng thái

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB26
)
gh issue create --repo "$REPO" --title "PB26 - Tra cứu đơn hàng" --body "$BODY" --milestone "Sprint 6" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Should" --label "dev: Trần Phương Hạo"
BODY=$(cat <<'EOF_PB27'
**User story:** Báo cáo thống kê
**Nhóm chức năng:** 11. Tra cứu và báo cáo
**Sprint:** 6   |   **Điểm:** 3   |   **Ưu tiên:** Could

### Tiêu chí chấp nhận
Thống kê theo trạng thái, theo ngày; tổng tiền thu; xuất Excel

### Công việc
- [ ] Phân tích và thiết kế
- [ ] Lập trình
- [ ] Kiểm thử

> Khi tạo Pull Request, ghi `Solve #<số issue này>` trong mô tả để liên kết.
EOF_PB27
)
gh issue create --repo "$REPO" --title "PB27 - Báo cáo thống kê" --body "$BODY" --milestone "Sprint 6" --assignee "@me" --label "status: New" --label "points: 3" --label "priority: Could" --label "dev: Trần Phương Hạo"

echo "Xong. Mở https://github.com/$REPO/milestones để kiểm tra."
