Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211160;
	b=ccFMyNMxIbS3R1ejlte8a8Mu2tc2qCj0aj/2lxSz4v/ffMdGYDYuOdWEGrpYyq5XYmxX
	 ZoWe+wdP0m+9Y3hF4YNfOn4pLBkR14tKrHUQUSFFUWbXDsGvyfs1PojwgRyU2fKQZHxA8
	 GnUVYk1Jz+3u+UfwXpcGjXdKQcfdNvtdzFYT3Xcoy7/9pEr0Rze6Ruf716ihJ1hfiHv7o
	 POw+rm6RJ7anDSJ0jB7VHaI5M6ncpT4b4GPWFoyYeuHkbNzjTyfudhTQJfhNsKwb7ftWy
	 nlKa3A3U34aaHd3zvx3G6+dRTIhkH8y6Ix9gWNVFtI13dEkITDjNlK03bSzB9jB/VFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
	b=TP0aBeZJUnF2XZIKFYwSGaiheHVjhBKccIwdwuJQ2ucYUOcBy2pKgXqE3CEhVuJ2+/mZ
	 intUsw7jt/Sc4urB+hCW4JhrOx0RckEw0gOnliSPha72CbAgkxICK/QqeCm37nMYGNwJe
	 L38DLUFY5dB1YO2RnmebAlnlNC+vJzeQx6BYWH78kxKnG9GCSTZPZW/iQW7nTmcKBdSyZ
	 pqKACFB3dGXnxO0ApwRcBmSTcrWsrjekgUBhdBZwirAqj9hZlb5v6Mn1Om6Z3VpEnFUQG
	 +vobMMamvhKQxQF/6vECBnY8FQxuv/XcyTv5lu3/sK2wu8JefKstg8ht5MLVlnSD+pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWpSky+f;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C240606A972
	for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 18:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C240606A972
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWpSky+f
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1810149eec.0
        for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211159; x=1793815959; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=zWpSky+fe1Zg+sGuV6ygWUy1bnfjrJGxIXUUr5+p5E9s+I6zWdPP9aJ3bCAVDeUTSl
         rMrInjKUZalE3e4hVmbuHaf2D+khOitbm6lmFhSZZT4w/dFVuUzVlO1V8rwxa0vW/bAn
         u08Kn6nQDKSWnayUIUD+GdB9dbfyFpNoyZsv/cLcYj793cL5HJZIh3HnAVcKrrxnMQbT
         yQOkw+dIgJnZcS7B0pYayjUgIbsSdR+fPe9VTEJvQbBeHcdYCQCd69rePvcsizcvmXWG
         j+wRQ2m6Uq1gLkyBEg4kYzWF2Pz9dk1XLMVPhGBPVIzfMHx+pwC7v/8CJFxuAc+79oXo
         IREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211159; x=1793815959;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=ox4KugxDsmRnGx36FvVYOFUvHWbgAlS6+Mi5z5CdvvZVUpHj/4riXe0ctJ97DaF1Sp
         ClAxzspqQnng+jwAcre+O9PPwTlWyAl3Y2IikSzIhG4HmBnvPPmT4MOztBplfV8BINla
         YfMHoD9nEoH+JLKGHxcmOYk5x3nR5YuafbnNxuqNkhDWsgDr/uQZw1GXO6vI/+srkuOT
         rj4CCk6UEwFtlu0Jds+KlCRIgk8Ak/pVo4Ir0CxJCXSNNRu8RVKz4AwmLq5Mu0JaC4Re
         neN3pj6NHPIZW8uP6UXOHjJ2sCMJ72a58evai6XsXbMS08HmNIYdDFxFRMoUAKZIa3HV
         tJEQ==
X-Forwarded-Encrypted: i=1; AKwUvByAE68BdLFaNvydhfUeNGQlNIn1WRrYX1GsmBttqXm40o+VmGjvyCEmPEH2APwujHbWsd64cg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+WLlr7altzy2h1GJCcTBJD+8i6XXquqHe/3NjLk+i25bFO7JI
	bVHC/ueHD4+vY2b/56NMD3mzaoH30NjWugaX2bJDjDM0Yv38wwBtYWf0
X-Gm-Gg: AYBFou1Wk8UhR35Q48OTbjaJ8mHB9JldsdCikOjZcfAwj9w7/rVNLBG2tUCJSDSsUN6
	EJQrBkhCdZxZUbg9tBNJiZN79LE4qzTeXpchGc6Awu7u9utwLNMrr948wkm5FS8D42e4G+S4Gwr
	WduUhIFw5+Uh3qMbxi1nkxNpP0n8ltVW3+k9KzmT9kTcFEWbgX6TmhBbvvzxxxvQz9oUvW0XDdE
	3eCtaUuJka0pwssuV8XxbUqgfmKeyrdH5s2bGFOeG2H3ThLNOOmWomqoQg46zBKQ2756O8P9Qhi
	9Kf0ECyv0Qny2OIuy7dKnOJuI/MoGGjeQgAEVQMxUuMytY/u1aktYsOYBdYaI70C9EXs0g6VMOj
	PKrEIQI3jnuGFXBAZrZY8ELD32Quh1qR3+7bsydt123ZWjRs4I+K0PYYZisPgKRs02Z3Y5wgRlf
	FDT3Z+Dj52niCpd89LHP0HWoMY0cZSdXFEds7AugsgfD+ozqaX2ecmnZngsT5/1hudFsTtJBnZa
	KfbxokAmGkG/N4bm6ED2Sh1f2ixTMu66d5gZBPQwLbDrQO+lMXWHFPOmbC3AyglmK52EECVF+Q8
	+Z5/UtODhfGB8uJcJuw+jow=
X-Received: by 2002:a05:7300:d706:b0:35c:6ffd:e91b with SMTP id 5a478bee46e88-36a2013bd0dmr5935780eec.40.1793211158462;
        Wed, 28 Oct 2026 11:12:38 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:38 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 1/2] netfs: preserve prepare_write errno on reissue
Date: Wed, 28 Oct 2026 15:12:28 -0300
Message-ID: <20261028181229.1408342-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

prepare_write() may call netfs_prepare_write_failed() (FAILED + errno)
before write_retry calls netfs_reissue_write().  Clearing subreq->error
to 0 for a clean I/O reissue (82e8885bd763) then makes
netfs_do_issue_write() terminate with 0.  The collector copies
front->error into stream->error and mapping_set_error(), which ignores
0, so writeback failure is silent.

Skip clearing error when NETFS_SREQ_FAILED is already set;
do_issue_write() already terminates FAILED subrequests.

Fixes: 82e8885bd763 ("netfs: when subreq is marked for retry, do not check if it faced an error")
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <stfrench@microsoft.com>
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/write_issue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index b8237e1314d8..f23364116421 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -268,7 +268,9 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
-	subreq->error = 0;
+	/* Keep prepare_write() errno; do_issue_write() terminates FAILED. */
+	if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+		subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.43.0

