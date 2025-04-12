Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF718D626
	for <netfs@lists.linux.dev>; Sat, 12 Apr 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744484873; cv=none; b=Lbfi4IazlL18TgSm9nMV0mFJav3PDQMAbsmTzHwn/nVUwLZwfgL/Bgi/Q2MRFh4/C63mXLPwAC0SqCQHqx7nh6ryEs9jSOHylBNuriZ3uN5TSH+LmijJDjyZErFsnkhlrRzdN+yFewLkrogVrhyY5fx2gld7jkal/9qNpiNiDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744484873; c=relaxed/simple;
	bh=LM4Y2I66wt8z3nQIZru/3jsXUlk20qXkrMEf05PQKFk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dmk6E7N6jHMZi0uT6LJlz22xDDdVHlQRwenipCWWXtXe/CzjPQU55Y0zzNTBDdYC3k5y7SwEeOX+lwaDUsN2olg2ivxQ76Hzbr7U5bONPta3IbCTltk0RpUCvpAKbYxobS/zOz3byrdWwY1ZV3YvifLmtlxoLCOL+SMw5sNhYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkH5eUUZ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkH5eUUZ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-871ac66dcb6so173792241.2
        for <netfs@lists.linux.dev>; Sat, 12 Apr 2025 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744484870; x=1745089670; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uqS8Y0JeeNJp+EZoySeyRD8ao4RjMPXd9tkoghzbAA=;
        b=GkH5eUUZArpgrKpxc/XhnWdX5UaNSr9gaCONbfBaGuuSKNGEBgR2DByYzT9nh32k9Z
         D80k6pp+2xIU0t94TCRaJp4a7cyq4Bg+1pT3eYulCcgClTPVzbQxJ+TnpWuR6A25kHNp
         HyebwJP8/0l4lLdlFFEgHbW+fwhm9RiBBicM1qcTfKCcJqdwngEE8G9Rf7/PlOeJIRUA
         Lctx0AU3FtxJLR/oWKdHklTlqV+Rokt8T89j7NvI6y8KQzV7IQs6v8XGhbcXzfIO8mFq
         w2B2kt/Pha+xLfz/F4pAxdEpgZqEIE9B/Pnh1ysIpvEYLsrxdceWJJkTmldCMwVIXnC8
         iR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744484870; x=1745089670;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uqS8Y0JeeNJp+EZoySeyRD8ao4RjMPXd9tkoghzbAA=;
        b=oANkAINeToDz1l1BSdcfQHRt2ZlKsfrwuU+bWsfoOLKeR+ogI+guTt3rSLupDxfRMV
         OSs+iCIhtOdlmCQP4+WPI7vYuId7DdiB2UlzDUgIUpIVav593HZmb5IIosZeVRmF/k0K
         rlQyeqgkCuIBCKdVQmYJmxMSTPZ/viQCn544R/hbbhPf+HP87vV/K0xECTd/uPRzRduu
         JpYAhynMSn6JQP9BtCxQF3rGG8wdFOhxLZsUYtf+H+X+Po3lzEM/6KQjUWwDqXKWkDL0
         FbLIrH1AAzg8HA7RA8GX900ma/FxGspn/p6ycSmCh86k6YMzbmwVHB3LNufRIBe9Gtv/
         AsVw==
X-Gm-Message-State: AOJu0Yy0saKi/8GNa78AyWPBO1+geBgPdYus8AHnwbt5spwwXdcQaFTe
	YdyVB/g97ebB+CrQIAeqitAzssFDl/Y1VhlQVgjqianV93BoJJFgUu1DBqXDF9IyC2Z1b+VvyCV
	fLtxmoKSMMwu3tV4lugoCC/J7eQ==
X-Gm-Gg: ASbGnctSGJHct8GZ41/D6Wu5ozuZWb7e0jqLqcCVJXW7MILWBveaRxwdBk/d+1asRsX
	Z5kLaPFeFopdQzSxonV7vqQemFRVcPqVmFGrpgwZ55EPqhYIpzFMaSRZLP90Z7o5iOxuBwvbxBS
	eAmVt1/2sSw7782DjMXjGUjbc=
X-Google-Smtp-Source: AGHT+IG0k+yhiUDsMVLkTuLC6kSDyeEJ84uZ4WA2XWYY1KbUy6V+3ZAbK1JX89b7gE6FzLIFEx93nYU8og6BgBz4HiI=
X-Received: by 2002:a05:6102:3e28:b0:4b9:ba6d:86c1 with SMTP id
 ada2fe7eead31-4c9e768918emr1550739137.1.1744484870238; Sat, 12 Apr 2025
 12:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 12 Apr 2025 14:07:39 -0500
X-Gm-Features: ATxdqUEU84qA93WFjYZD-conKUCSsApMtwG5XxM0OfTP-Hfdm9RGr15WA6pQlZ0
Message-ID: <CALGdzuomL+AACikTfBYBU4nCMXGU-eRvSYwdY-b_6n0mUekBOg@mail.gmail.com>
Subject: Question Regarding Optional ->prepare_read Callback in NETFS
To: dhowells@redhat.com, pc@manguebit.com
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear NETFS Developers,

I am writing to clarify whether the ->prepare_read callback can be
NULL for a backing filesystem that does not supply it. In particular,
should we assume that the pointer may be NULL and thus require an
explicit check before invoking it?

For context, commit 904abff4b1b9 ("netfs: Fix read-retry for fs with
no ->prepare_read()") introduced a similar check in the read-retry
path. I am proposing that we apply the same consideration to the code
in netfs_single_cache_prepare_read. Here is the relevant patch snippet
for reference:

 fs/netfs/read_single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fea0ecdecc53..68a5ff1c3d06 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -63,7 +63,7 @@ static void netfs_single_cache_prepare_read(struct
netfs_io_request *rreq,
 {
  struct netfs_cache_resources *cres = &rreq->cache_resources;

- if (!cres->ops) {
+ if (!cres->ops || !cres->ops->prepare_read) {
  subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
  return;
  }

Could you please confirm if this is the intended design, or if any
adjustments are needed?

Thank you for your time and assistance.

Best regards,
Chenyuan
