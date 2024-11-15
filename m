Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C441B6D1B
	for <netfs@lists.linux.dev>; Fri, 15 Nov 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675228; cv=none; b=JV/e/FBh4LlNAaIXnkPDbFcKL3v0GoQXPsPuPSJzqoMO6RXzZeulgB+Fvp0r3gFpdGIWzwxtbBXxSdCm5+Q134UXLcYvvTzNLGPd4sTkkSaqLuliphnlm/XtufdGT+86PBOwkjJRM6YDkgkuf8fqJm6X38I4KiFyipjP7q6snm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675228; c=relaxed/simple;
	bh=kC5b4Nc50fbhWMMi5vOolJEMARSuns1Kxgz8mfrxf0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JLLqXwtl3Io78fgchpyngmFy4vBW03eYmKGbVYhKgj5YgZsHre70PS9hmUHtmTiPvSc0dXmnNchTesMOTQ9hG73a7n4cIb2HcyeorVnWNrFUpSBQnNxgQR1eT9O2WYBV2uoUsy87HxxL0+YjNIG9bAcCKI+5QP+YQkwaOjlUPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hmgIjsSP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmgIjsSP"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-513de426863so746411e0c.0
        for <netfs@lists.linux.dev>; Fri, 15 Nov 2024 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731675225; x=1732280025; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=hmgIjsSPOTdUQLBVwihzecNUPbO0vpNM+iCpHkC9tlKWwcxsZCuc5JRBJ+AJ+gKrP1
         D/HouSVYup1l5nWOfOtK8LZgXMaOENlMNxW+E+MTTTJDLuewWawevntnG39UiCkeFCXr
         igc5Tb9iGBKpOy0x+cIvCV0IrvWvzuwQgGtsKwbqtjMyNnKDlg40xcDrlkFwaqJddL5L
         ILU4WDdP2p1j7gm+Iq8i35YkbG9OJjFwaGqA03hdS0Zcnv7PK3TME0O0u8RBxC/UmRfy
         10YA8TiJGrQ8/N7xH0fBf8bpW1ZtUL/71Gvo+mylg2Hjcj/FoXKJilSlm6JFnrYG/MsX
         kM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675225; x=1732280025;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=kRxuABoLeA/hijHr/GNJPTqbjq+zm3qOpRCu3VZn/dvlQu479iWbF1tPzuM/jY3F+5
         Dlk2RzNaKvoAqM23GcSWPn5L84BliFfQKXD8pceatIeXMSjDHaOGEcbYhXBuRShYBLdo
         JsyInOMPNerbAijgmmOCkHDj2L02dMPv0MFrk0IUwS1i1nsoeD8HvlOxDZNLl7j9nnqm
         GBhokvQpgQ1uq22/Vy9+Ls25B70HMMaGaCXP0D4nmD0pHaGCEyeGW3EHxVe8L4KhdoSS
         6/+LNY3KPxM2oK9jL8vY4rh9btuRzxGLsfU59a5kzQBvsKpX1IKlEzu8T+eABjkG1ZJr
         mu4w==
X-Forwarded-Encrypted: i=1; AJvYcCWb/mts3wjLMcllSUHmZmVQJAPPL1Y1GWmklZoM5uTwrMex5uaCf969gs817e17ZlqSDVlb/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8G/EGA5+caPE7EbC/lEUiNP86KhUGsuun6W9+0A73rRpzkdw0
	tZDMfDMdKhTsp1HD05Wy15qOlRRC+aD4q5tnKZEDW+5klZZfr3V0JwFKV7z3IElD45rL0OGqIyg
	xxlJspwrgXsxdyFAyRFb7d481RJnwN8Q3Eprj4g==
X-Google-Smtp-Source: AGHT+IEtDEtXKpcCidRqx6bebqrisPTC0Px9Xm1sUVNWuLsQVQUre+hBcxnbLyeeXGplNKk47hIC4CRTO6saY/xxXGY=
X-Received: by 2002:a05:6122:8c22:b0:50c:79a4:c25 with SMTP id
 71dfb90a1353d-51477f7c9f3mr3308737e0c.8.1731675224854; Fri, 15 Nov 2024
 04:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Nov 2024 18:23:33 +0530
Message-ID: <CA+G9fYtThFpgHJvVwmvp274QJ0QBbrsr+qnYi0b5fWJ5oJL2uw@mail.gmail.com>
Subject: next-20241114: clang: fs/netfs/read_retry.c:235:20: error: variable
 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, clang-built-linux <llvm@lists.linux.dev>, linux-cachefs@redhat.com, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following builds failed with clang-19 and clang-nightly on the
Linux next-20241114 and next-20241115 tags on x86 architecture.
But the build passed with gcc-13.

First seen on Linux next-20241114 tag.
  Good: next-20241113
  Bad:  next-20241114

build:
  * clang-19-lkftconfig
  * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
uninitialized when used here [-Werror,-Wuninitialized]
  235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
      |                           ^~~~~~
fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
silence this warning
   28 |         struct netfs_io_subrequest *subreq;
      |                                           ^
      |                                            = NULL
1 error generated.
make[5]: *** [scripts/Makefile.build:229: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/log
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241114
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 37c5695cb37a20403947062be8cb7e00f6bed353
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/
  toolchain: clang-19
  config: lkftconfig
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org
