// Fill.asm: 根據鍵盤輸入控制螢幕顯示。
// 如果按下任意鍵，螢幕會變黑（所有像素設為黑色）；
// 如果未按下鍵，螢幕會清空（所有像素設為白色）。

(LOOP)
  // 檢查鍵盤輸入，將鍵盤的值載入到 D 暫存器
  @KBD
  D=M
  // 如果有鍵被按下 (D > 0)，跳轉到 FILL（填充黑色）
  @FILL
  D;JGT

(CLEAR)
  // 清空螢幕：將目前偏移量 (offset) 的像素設為白色 (0)
  @offset
  D=M
  @SCREEN
  A=D+A
  M=0

  // 跳轉到增量偏移量的子例程
  @INC_OFFSET
  0;JMP

(FILL)
  // 填充螢幕：將目前偏移量 (offset) 的像素設為黑色 (-1)
  @offset
  D=M
  @SCREEN
  A=D+A
  M=-1

(INC_OFFSET)
  // 將偏移量加 1 (offset = offset + 1)
  @offset
  MD=M+1
  // 檢查是否已處理完所有像素 (偏移量是否超過 8192)
  @8192
  D=D-A
  // 如果未超過螢幕範圍，回到主迴圈繼續處理
  @LOOP
  D;JNE

(RESET_OFFSET)
  // 偏移量重置為 0
  @offset
  M=0
  // 返回主迴圈
  @LOOP
  0;JMP
