Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835171F931
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761200; cv=none; b=o8qGOC4rMkTSkExlgXy4ykXjCuMMeFOa/hP66JULTbv9MyZyoyiiEd0V7Kdyn8t45XhZNcm3lLJDF9UIgSNMqXcXuC0/rqEnz99li38lnxqmq7soIJx844YOGq28awivL5+7zOqN2ruQ8WP4k/YTSE5DsBJSvxqOf91rdX73NgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761200; c=relaxed/simple;
	bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdU8oLT16OkZUYSK+eJzsBZJjttscVwhRrVuuFIBmsfAd6se+NMZ18Bmn8Tyfjp/33VfIhrOQoVsOH0xyvRSn2fJN2FCvhywnLfV53DbHkqn0fepMquN0Q4/GsEH5Dlhs4j5Ul3JYgV2X44timx7jibu3asidQGFl7/LIdq6MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IhgBWEHN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IhgBWEHN"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so3371793a12.0
        for <netfs@lists.linux.dev>; Mon, 09 Dec 2024 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733761197; x=1734365997; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
        b=IhgBWEHNLKiL3YZ5f9EU/decqS3+zM8zao9BnaZ5xyDi7NkdNAEG8JwnqhOugnMwqy
         Nd2dc4QjGSqrahdqpHsW1DcxLKkSrT4uS2O5UVSScDcXXa0y4lRJdIFFQoDWBAu2O1UE
         boUskp3VVLDro6zUEXKEryFDrKVdxcCvdvAR5eTgJcdGPXfiIgs95WqDeSuRhJ8ycetV
         2F4uAG0F6mXzl5Jr4AvnXi6xnJLSpNklXgz0Axr32WLIdqP4TYj7dhV9NsHfPCmk3OgW
         TVGRpVmASstKT2mEcR2maKbjpn+0dTGd7RRtZAEqwBIpfNOnlnb/jhQmhlr04ChPukSV
         deCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761197; x=1734365997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
        b=rCSR9U7k7pGNsKHla5qR3DuvMGk5XMrgt7uBRKZFns4uySveUjOm90uBPI1mv4+7fH
         eV/eNdXv0vsUHlyGzRA5GJZ5+NjFS5rKuvk+HzRvRMAIMFfla6DJkbh0BcV5aOxDepxW
         sxkZsvlzYCVCN/e3yYWdoy3Jl2um2gj8aNfveTT0Mq+maq0aY2FK4au16pcTcoFgmGWW
         qitKHQkO+Cfk/z9gx52GcYaYGyprnX5kV8RPARQm5nV6qqYMeVjN+ezI6o4JynY0wZf6
         rsETGJnEHK4yyOSSu/FiXNCIRR/KQjkv2BbRFYS9Oakks13T2Ut+5co3Fh2SheIWCNWi
         tPUw==
X-Gm-Message-State: AOJu0Yyw+wvAsvXA+jc9IWQ5wCsglYy4UgcE1IKGmDBPz9hFMWcv/esP
	0GRa5EWKMRAhAMe1cZJgwPWNc0tgf8k/EwoDb3Yc1IGHPkO4xi5zADEy7BDdy78IOBi+Bl2FDZI
	sFrq/NInCgBhLYAEU4TxW7HBcIsGK0uZaVkdXWw==
X-Gm-Gg: ASbGnctK03i/NjKZOpJ6syEuGNiRmrcWX1x9JHZHv6pJZ7CZmbXlkxEgXKujCyk6vjH
	meRtXd8t8YTbrDczr+KBTgM3eKn/0Od5q4xKojNlbA5S/dlCvefZZbJTjqfiB
X-Google-Smtp-Source: AGHT+IG5j6CX7ksLi+fnLfDIMXcwXWB37sJyHak7p6g542WsOHweAQ9hXBgNTypD4LpJ/oR36IJikj8gKuElWQfQyrE=
X-Received: by 2002:a17:907:90d5:b0:aa6:832b:8d70 with SMTP id
 a640c23a62f3a-aa6832b97camr524912366b.3.1733761196967; Mon, 09 Dec 2024
 08:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209141554.638708-1-max.kellermann@ionos.com> <2133497.1733760235@warthog.procyon.org.uk>
In-Reply-To: <2133497.1733760235@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 17:19:46 +0100
Message-ID: <CAKPOu+8Q0tt+wto7Ey7HoG3TKKUNOxX6H49=iuCPqhscZiE3pg@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> You don't need a comment there.

It's a question of personal taste. The Linux kernel contains 500 such
comments (git grep '#include.* for '|wc -l); apparently, many others
share my taste. Of course, it's the least important aspect of this
patch. If you object to merging more of this kind of coding style,
I'll resubmit v2 without this comment.
