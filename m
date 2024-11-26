Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90030199924
	for <netfs@lists.linux.dev>; Tue, 26 Nov 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609527; cv=none; b=Q0Xjd6a4JmIfokrldH4piepEEbaQ7ZftuAlQnLvFy54gbUgqyTcjuHBpi1Xc4Fu0RXE2uhe+SuLHzxOoXO0ax66CvR84oWziN3BVdrTP9S9saCO7lb6R10gYdul7TWVZCYBlguk8YbsSkZpGuHAsiWjGNtfXvzvRgj7sW60DhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609527; c=relaxed/simple;
	bh=sI7tNk5+zKeQtAWcs3AksLYA8Nbczy7AgLIX6hl0R9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=prXFq+5yP3Kr90RgNGiIJDaXLXdlFt5zB1kTP7JZKWOa3yo2K7xMaMlbXWpV3e+dbn7kH/nni7Rm22xLWw3YIa7p9gQjjj6RP/+n5ffUU4vrvQLwoHWQhBPyXVJhmh3tRWCqPmJPUMoGZo5tAaLfuqximAbyKpQJ/Cvz8JJ0Ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhEIWIjN; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhEIWIjN"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4af07a8d444so790233137.1
        for <netfs@lists.linux.dev>; Tue, 26 Nov 2024 00:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732609524; x=1733214324; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=NhEIWIjNXB6cbs4CDBjbc4T1tsqJFNpY4OrHBPm8AXDOUU+3gdin0n4jHg6f2pmArx
         BhdbpaTvRRDB4T/Lz3CsV23G02OG6Ey8A0Yz5Ow4VkF+6I/i53QiVjJqGU3WcbvU9/gN
         BYJGKQ+ySHcBFDntcAtud9cAsRcoSXBp/RpHgUNHgYtxCA0wRM20aCdRSFvQCizAChUu
         lodOqBmrv+l4VTFY4a8KHtySDW+K78BfRKj0umoEtJRE+EnuwjEWjwhgt20hVQjSUK11
         j+bo5EAS568wE2u2ucw/J+sxLNomXMA8Reolef9VfPd8PUZhovMFCQzYhHxD2j1faDMO
         BNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732609524; x=1733214324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=hqwJYJQHc1F1m6LWu1PXYbzxUl7FUeV1Yn8TiBMBwOSKQDrT2waGXDtQESzsZOi82B
         iDDKVNRDMmTSxXWSo1iIkEG6G4jHYIv+mzgv8BPI+H2Dp8kYgm59IBoYJhPDpbyVEgM1
         0KqBz6++NbgCP6kN77ffuaPCQhiXLbbX+y2fEuAfx26yKf+AFB797tWj9SY8piRXHYY+
         lKqzJx2YILpWfbpYq9FFfBu7y9RL1hFAaRdVkJRiW0AsqT0acNfSg0WXgAyx3gK2WiPJ
         vlHUtT+Ru1alI59YFsY08v8sRe9yDefgir2DpZLyYqEdYE+wYaYnZOo0FlTDnnITHr+G
         bp4g==
X-Gm-Message-State: AOJu0YyBo/z6L7lxLw9eBl/jl4igxFbmb3hukf8hyRSpJDFcrXCDDPyr
	s2H9i/JurFfClG93acji9/7lAptUWXwKHqTAjvA9nTzXOvd2e53IfLriJJnMwIdhjORYHHxYqNU
	vZf5yyMW43ExCOOtWvCSa5R+AD86VqXPLW6bWgTuEDFM2I3V9AR4=
X-Gm-Gg: ASbGncsjCJBIkGyxNsy4UI3DQd/+Tkqjp/892gsPKmLdvDihfgmnhXnCDT2E3v2pDaY
	m8Hj03bioqnaMa6MuYu9m4Vn49RstIDFEKsomqa5/k4aKiwGvuLJM2hXwS55oGRhP
X-Google-Smtp-Source: AGHT+IHfmlOUT07xsGM81ccGUL8gokcmILu2aWCHpE5lTRyBqDIA2QVqqjf2o72oJuOxTAI/oybzlUneyIUgqtnDACo=
X-Received: by 2002:a05:6102:9d0:b0:4af:476:f3ca with SMTP id
 ada2fe7eead31-4af0476f4e3mr9401237137.12.1732609523827; Tue, 26 Nov 2024
 00:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Nov 2024 13:55:11 +0530
Message-ID: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
Subject: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The x86_64 builds failed with clang-19 and clang-nightly on the Linux
next-20241125 tag.
Same build pass with gcc-13.

First seen on Linux next-20241125 tag.
  Good: next-20241122
  Bad:  next-20241125 and next-20241126

x86_64:
  build:
    * clang-19-lkftconfig
    * clang-nightly-lkftconfig-lto-full
    * clang-nightly-lkftconfig
    * clang-19-lkftconfig-kcsan
    * korg-clang-19-lkftconfig-lto-full
    * clang-nightly-lkftconfig-lto-thing
    * clang-nightly-lkftconfig-kselftest
    * clang-19-x86_64_defconfig
    * rustclang-nightly-lkftconfig-kselftest
    * clang-19-lkftconfig-no-kselftest-frag
    * korg-clang-19-lkftconfig-hardening
    * korg-clang-19-lkftconfig-lto-thing
    * clang-19-lkftconfig-compat
    * clang-nightly-lkftconfig-hardening
    * clang-nightly-x86_64_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
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
make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
LLVM=1 LLVM_IAS=1

The git log shows
$ git log --oneline  next-20241122..next-20241125 -- fs/netfs/read_retry.c
1bd9011ee163e netfs: Change the read result collector to only use one work item
5c962f9982cd9 netfs: Don't use bh spinlock
3c8a83f74e0ea netfs: Drop the was_async arg from netfs_read_subreq_terminated()
2029a747a14d2 netfs: Abstract out a rolling folio buffer implementation

metadata:
----
  git describe: next-20241125 and next-20241126
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/
  toolchain: clang-19 and clang-nightly
  config: defconfig, lkftconfig etc
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org
