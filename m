Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094B4EB38
	for <netfs@lists.linux.dev>; Wed, 22 Jan 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536609; cv=none; b=fOd35xz5eVpgPZt9qwyYkRPMdz4do0CFRvlsWEDSJrVvYKWwo7LOqT/sCVw69Av9L/PBXZfAz3bAGSzQym7xWm9ggKEE2LljQU5OmOFb/iRw8f4G1mcoIQdeHGfUfrCnONdBtNEdjtxEulAYGuJhX7XjvhVcmunsWppwfoejpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536609; c=relaxed/simple;
	bh=qFbPnK0PIjJquXMv/pF6+wmsX6N8W+dNvjtMoGkLcsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3taGQnVuWJAJkyoeTj/0avhDXbM3hW0cWEQc1It2+hZYWbP5GPLNb0iOWP1lZa3rS09Fwf60UaMot+sFF/OlrdmSKJZZnXsw5+YduhsQXu/S+vVeAuaIqXvQIhPz+c7ZbKaHuIMAq0ntI64BdXhphCfd76blYEiji5Vx0TXYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkczxgux; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkczxgux"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e27c75f4so5484985f8f.2
        for <netfs@lists.linux.dev>; Wed, 22 Jan 2025 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737536606; x=1738141406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXa+CLoEfsGPQncdzFfwSdHRxOfs4sQtMC3wnCtXOzw=;
        b=mkczxgux7mmRqBgs4TV8a3i2K5RQuDhtTHF/V1JLXBz+ILuqILT5k4bpsj/dCmiwfw
         bri6gKWzJH1n9aYWLL9PxND434RWfRrMQXRcxZ15J+AgzQVAZI1neyLeueV16DW+qsjS
         YyaWyDzmpIOj2CHY7nhisOqaPAkGYDqRx+lsWYR97hHvZJ4iDDDmKkOae14JBcE2z46k
         CXmoCmJ02vf7kxSoW1ekg1T81tknEF7lu2qw/sOChNtqzph0rG3UWXqTvtuGfQMHR5g1
         rQz4lCCyM2Ynp3yHDWOMUsicPaY5oPKUhw8eXV0sNtFtA4nFXkcn3p/a/pAWmyJQr1o/
         Sqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737536606; x=1738141406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXa+CLoEfsGPQncdzFfwSdHRxOfs4sQtMC3wnCtXOzw=;
        b=eJW52w4R3ew/35SXkv3X+oA8EOTQMNC/VMtpgiMIG5QoSd6654AnLc+C/XhDhi9oqg
         xOaJcWlerSao+UFtfeQSmiPQJzFDm24ayKz/ik1RnJks8PRpqxrMFqNJMExTIDZgO2X+
         Ylpg2+RuU5NW7ozxjq+QPKd+Ytyql7JDRhqGmtbejNo5qeyS3zTcURkYrKcif3p78C3D
         qyFuxypyNmFO+9OmT9a9iofJ1bgPSs4sYQUvuAFg3rb8lpkzRxRE9V/n5ExL78OEOBzY
         82UohzLMiXw6qFdMuQHY3Cgtlz8KYmQtMzu7jdMbLE5FLWxOPV3InG4zd7zKy5cErYHP
         oijQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmbNLQqi/tNBa86TUWwAS+GAnOpHVgLd1NmBHbxVZznnLHsxWsiU+7Ij5Rn9svEWloN3+qPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzymrJKgKsoe7O3IuNBd6Jjn5I1F7dhMBRFqNniC/v2F+xUUuLb
	9wj6D3SbnM3biOT3jMtpAhaRYhr2en98rgaqVeolBaFAwmbFor+/
X-Gm-Gg: ASbGncsCzpfOHmpsk8qOYKOFtj2HeSZMqEFVTcvt40FtJ3OrwQNIVnYmWjKYbqhSXdl
	FXigDRqE6MCj0yiaCJrIX1lVnsgrScVviAkC5zAztkXookRoYOyO50hh5jlHaBFdo3HMO9RwILf
	Gcupx6lYnct4jVOzwBhphdn/6zNMojijOmF1FVvKCh2M2l0KzaSM9SlrNLOdPvfRn8s4BIIjIsk
	UPz/WwEKLqFY688+gvK8McgzBQ5ojOcscjQedOVvqY7kydAZESKQiN8nsKlHMbcYY25U8VNuVId
	5G4i+A==
X-Google-Smtp-Source: AGHT+IGXGhemsPVUtNP+jdBatlh3IZncnXXvARsLkr1lNZDkeLiqZmq3dWZODp9aB9WOIRMwNX64tw==
X-Received: by 2002:adf:ab0f:0:b0:386:3711:ff8c with SMTP id ffacd0b85a97d-38bf579348dmr13365674f8f.23.1737536605753;
        Wed, 22 Jan 2025 01:03:25 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.116])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm15948152f8f.72.2025.01.22.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 01:03:25 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: brahmajit.xyz@gmail.com,
	david.laight.linux@gmail.com
Cc: dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH v2 1/1] cachefiles: fix build with GCC 15
Date: Wed, 22 Jan 2025 14:33:06 +0530
Message-ID: <20250122090306.1524098-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
References: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building with GCC 15 results in the following error

fs/cachefiles/key.c:12:9: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   12 |         "0123456789"                    /* 0 - 9 */
      |         ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to GCC 15 having enabled -Wunterminated-string-initialization
by default[0]. Here we're increasing the size of cachefiles_charmap from
64 to 65 to ensure space for NUL. Unfortunately using
__attribute__((nonstring)) or converting to unsigned char [] didn't help
in this case (thanks to David Laight <david.laight.linux@gmail.com>).

Please also refer:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178, and
https://gcc.gnu.org/pipermail/gcc-patches/2024-December/671714.html

[0]:
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/cachefiles/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..a75ea693f649 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static const char cachefiles_charmap[64] =
+static const char cachefiles_charmap[65] =
 	"0123456789"			/* 0 - 9 */
 	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
-- 
2.48.1

