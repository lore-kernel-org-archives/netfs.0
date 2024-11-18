Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB71E7C0A
	for <netfs@lists.linux.dev>; Mon, 18 Nov 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971094; cv=none; b=Vuu4MVZ+5lkYQRkTUCR4B7dFyExRQ6x9QZSmuoyd0FvsN5Xz22n+fyJ8MsvZl9q4Pn1GWctsmFMqBeTaobbXIdZH6NpGubK2hM8pYyDOOpahofpHBmK8zDK2sSIAZSb536iLKGSAL/tTW/SELMEsQwry/O9DwbFcO8QvYR3R1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971094; c=relaxed/simple;
	bh=n+a8PuXE7mDwb+sHUuiDQENu3OnJfAOi8CDZy+eFDro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DvQ+zkvh3DJno2OxUICLbGPDHE8fOMYSNZjUlpnB/mAYYbacP+OaYiVXgufTEJ3V46wPsmqX6dbGgXZP9C52KCH/j3oUayPZq2o3I7yFqcHnXSUzs4YT/yqzxwwLjcY+qlWvRDZHKWR+QJtqOAxlyxY2tvmShLEz2P8Id6NzpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iUx77/IV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iUx77/IV"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso549850766b.3
        for <netfs@lists.linux.dev>; Mon, 18 Nov 2024 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1731971090; x=1732575890; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qz45Yk+OZAn3aqvYW6rBzIQz0s3A9g2TxXk71dPeOk4=;
        b=iUx77/IVHRZMBo7DTBH/0TFri0WtLxjOQFXREB/UJN8u3v3/vljoR/byxfje+JFHqF
         MKUH6s3mYFszTqSqDRjLEUZMlaigQgHzBPgiS310UpJvcSv4pkUmbK33N6dN9x9m2t0x
         qq+nXv35mR+GGmfvK/+atDc/JkXoHSrdY24jN+U5zUzwWWzhHMsdfhNTOEb/Nbg3tSvv
         On2/jtRXUX+1N4WWPM5/0/1edawyiKINCupPHvLNOpi41ubzA3FisTmShh2sE8ksL4y0
         Z4WK7QoxJccsy4gDrQDtLUQ7STXFI/gzj+jlorygfcbbIJfC5UfyzH47Q1kfQtmMAwJs
         TF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731971090; x=1732575890;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qz45Yk+OZAn3aqvYW6rBzIQz0s3A9g2TxXk71dPeOk4=;
        b=oS+U2JGufmujm6d1X0itOju4pgV0ua0BVfu5WSL6Ri5doOgarMqucRu4NCkJQb8EHm
         IIxIwES34HKsPHxkOUrbOCWkDSpIWxOyIMha82KILzclxTLYwGGYSxXhcE1bOVlvuqEd
         CkmEAfSZgC7PC+9xXEnc3TNSPOBujphBryQzLOVT99zeV6IzxbBXLnDyJ1jF3JjHkyi8
         SZTtbMUwcVydMg/nj//bgGVxVtwAcBpCaD0OKNFf847O+EI+TZT0O/MHU4BX44o8WV8E
         52dADs6z3Dsmhbgu5cQfnufYTHphCg5yDFWP/pjlYEXt7I+8+C5QDgpLoBdoqntfFPM0
         jpYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXqSpI/AjjH4w3FqyDtdY9qW0rBqrPc6+nn+PJSNikFdq9pGy1ZBwgE+9T38owcohR5yGf4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKkUd7VqLX6CeLrqMtVYgIBiWjPIhl66EZvczZl2+tAZhgaciu
	+V//7x3h4rtYC0y+cn/oKXsR2p9n8NRZ9tXOv6vovF8BsrLT9zUK1wtSdYbNZP1IBiMq7QJz8Zb
	CgRbA3FfTB33Tp7d67w5XctI81IbLgfo6Prepkw==
X-Google-Smtp-Source: AGHT+IFcV7cE3gugVtN4+LbUlFLVHjuCnk9W/PBfqGTK509rJKvyu5E24GpP5IS2ehj/lxDSnDVAAsJi/JJed28NdO4=
X-Received: by 2002:a17:906:d54b:b0:a9a:4f78:b8 with SMTP id
 a640c23a62f3a-aa4833ec1b5mr1139023066b.2.1731971090208; Mon, 18 Nov 2024
 15:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 19 Nov 2024 00:04:39 +0100
Message-ID: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
Subject: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David & netfs developers,

I tried the new Linux kernel 6.12 today and it quickly reported a bug:

 ------------[ cut here ]------------
 WARNING: CPU: 13 PID: 0 at kernel/softirq.c:361 __local_bh_enable_ip+0x37/0x50
 Modules linked in:
 CPU: 13 UID: 0 PID: 0 Comm: swapper/13 Not tainted 6.12.0-cm4all1-hp+ #236
 Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS
U30 09/05/2019
 RIP: 0010:__local_bh_enable_ip+0x37/0x50
 Code: 00 0f 00 75 25 83 ee 01 f7 de 65 01 35 2a 93 d8 70 65 f7 05 1f
93 d8 70 00 ff ff 00 74 10 65 ff 0d 16 93 d8 70 c3 cc cc cc cc <0f> 0b
eb d7 65 66 83 3d 24 93 d8 70 00 74 e5 e8 45 ff ff ff eb de
 RSP: 0018:ffff979300464d30 EFLAGS: 00010006
 RAX: dead000000000122 RBX: ffff8c5cd1045b00 RCX: ffff8c5cdeff7800
 RDX: ffff8c5d022f91f0 RSI: 0000000000000200 RDI: ffffffff8f5ee1cc
 RBP: 0000000000000000 R08: 0000000000000002 R09: ffff8cba7cf6eb68
 R10: ffffffff910621e0 R11: 0000000000000001 R12: ffff8c5d022f9368
 R13: 0000000000001000 R14: ffff8c5d022f9368 R15: 0000000000001000
 FS:  0000000000000000(0000) GS:ffff8cba7cf40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055ea9986d368 CR3: 000000603ee2e005 CR4: 00000000007706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? __warn+0x81/0x110
  ? __local_bh_enable_ip+0x37/0x50
  ? report_bug+0x14c/0x170
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x13/0x60
  ? asm_exc_invalid_op+0x16/0x20
  ? netfs_consume_read_data.isra.0+0x3fc/0xa70
  ? __local_bh_enable_ip+0x37/0x50
  netfs_consume_read_data.isra.0+0x3fc/0xa70
  ? __pfx_cachefiles_read_complete+0x10/0x10
  netfs_read_subreq_terminated+0x265/0x360
  cachefiles_read_complete+0x45/0xf0
  iomap_dio_bio_end_io+0x122/0x160
  blk_update_request+0xf1/0x3e0
  scsi_end_request+0x27/0x190
  scsi_io_completion+0x43/0x6c0
  pqi_irq_handler+0x108/0xcd0
  __handle_irq_event_percpu+0x43/0x160
  handle_irq_event+0x27/0x70
  handle_edge_irq+0x82/0x220
  __common_interrupt+0x37/0xb0
  common_interrupt+0x74/0xa0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x22/0x40
 RIP: 0010:cpuidle_enter_state+0xba/0x3c0
 Code: 00 e8 7a 06 1d ff e8 45 f7 ff ff 8b 53 04 49 89 c5 0f 1f 44 00
00 31 ff e8 83 38 1c ff 45 84 ff 0f 85 16 01 00 00 fb 45 85 f6 <0f> 88
76 01 00 00 48 8b 04 24 49 63 ce 48 6b d1 68 49 29 c5 48 89
 RSP: 0018:ffff97930015fe98 EFLAGS: 00000206
 RAX: ffff8cba7cf40000 RBX: ffffb792fe94f250 RCX: 000000000000001f
 RDX: 000000000000000d RSI: 0000000037c86db9 RDI: 0000000000000000
 RBP: 0000000000000003 R08: 0000000000000002 R09: 0000000000000020
 R10: 0000000000000003 R11: 0000000000000015 R12: ffffffff9125b220
 R13: 000006c7b80e3e03 R14: 0000000000000003 R15: 0000000000000000
  ? cpuidle_enter_state+0xad/0x3c0
  cpuidle_enter+0x29/0x40
  do_idle+0x19f/0x200
  cpu_startup_entry+0x25/0x30
  start_secondary+0xf3/0x100
  common_startup_64+0x13e/0x148
  </TASK>
 ---[ end trace 0000000000000000 ]---

Apparently, the netfs code doesn't want to be called from hardirq
context, but the cachefiles read completion callback may run in a
hardirq handler.

This source file is new in 6.12, so this regression may have been
caused by David Howell's commit ee4cdf7ba857 ("netfs: Speed up
buffered reading").

Max
