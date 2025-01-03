Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088917B402
	for <netfs@lists.linux.dev>; Fri,  3 Jan 2025 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945898; cv=none; b=i5dGnsRXFh/avUkUWexjFdLi04w+zu9BimpVNeHkWBjujU9O/Oh6RRW/v1oprGhM95G6dkbC8aXPxEI9nU25ImhpXVa+QeP3sxKlpFNvccfXjxAL+ZtNsYGe98MEAjAM8y6tTe72y4vFZXngQcPDTdXQLBpBiyWEovO5lGayr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945898; c=relaxed/simple;
	bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex5Fhe7fNff4aBgHJxb5eX8isDpcTeY6YJlw3gwQWo3KuD0C2v+hHcn5VTPvcUWbJAyM92wlSiH6K/3QbJPpwava3K5t4GvpI90+bSsBTL79gaH+NtKN5O87Z6m/IAf3Q/NKAJEA47WKz2FEWrYA8cFZQgAlMW8u18FPgCZpVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT5Ppnsz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT5Ppnsz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a1d43821so120401931cf.1
        for <netfs@lists.linux.dev>; Fri, 03 Jan 2025 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735945896; x=1736550696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
        b=UT5PpnszjCYejXth590MaWOoDu3CAi26pS11fIbgYn1ubUl1YkGreGZ+IIl8kUp2r3
         LLym5ExaBVkLNjsjv+SQtUbCOaUZeQXWhhDeA4fsASbb0MwCNNz30PO5el7ty3qO0m94
         /vlLKfIl30lrH7PgF6vQqXrnzjRSqmlAf0oqH/5zCPzRnKpd7X3TD12UXQrmR0v9YvJ3
         I2dAEHESsjDWOW3QEOU25NLLE05751wtsVhdFTZZY5+gRXsrQ9b+M51If/KZ59RhhR27
         XiXmJ8QyCzR2iEdfT/Mjbl3BmDW/mh4H4Qfl6FFuX7xiuuK5bEAAByn18rYO+Hdu4Nx/
         dqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945896; x=1736550696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
        b=fKHHcNWdUKPoCppgJLNHdaT4VnpOcVNSx2S69aAa9D56iiMri0LVdV3A8Uya4lTACd
         KM1wV/65iyFFdzyZSm3QiI7IspBJNawfIvbQq+y2vSH6FyYO4nM5baDc85ymmXNBWhsK
         +Od0GnYvwQUB6X+NuM7UePpzPm6AE3VFFm6fS3RM+GjKbGWWi+2cd55xWCsKaxoYTlEp
         vd7kHzt/r8vTgr0d7MYdvb5Xvl94ewciAYSdcOAmAnF7uWW39TYb7UBRB0dm9nNf4yQt
         i7bdvsA+8x6EgCLI7VJb+KbtZyo70ppPOYyqUaGLar2Rhq2DHmaNSV4Gl+vlXXwUVxt5
         ksEw==
X-Forwarded-Encrypted: i=1; AJvYcCUgwiXIEY4PK/cJweT0/kPj5MiXU+tVz8QZYe7ciwHz023rr0KrUwJpf1p80Cg/QeJ8JIWU1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUm8udbmzY1bbp3S3Gi19uQ99qOt4MkMDViqlGFqZr5O2ldPs/
	SNyBg6G/p+0xhfzlR4vzmLroYu36mjpfaFEGqQI+v9U7fj5StX080rNxi+aWPqy+jPKkG36dE5S
	EZPr2BHujCAPehsZMzAsw1sDYLlo=
X-Gm-Gg: ASbGncv1F4ETXf7H5pCxwiWloqyi9/p20ljaba+g5rtpwEjWdail+t9MYrJmEkfK8Ou
	dTTw0FuRe9njfDxFd5qOY/SmtF6Z10SaFMUTtuiY=
X-Google-Smtp-Source: AGHT+IE0sYxgffs8HOAzg4jFNz/ATU6VSq8U82LvRAmkbSGFUdnQbwIZ/8z0CYEzNYlVLHFsgab0L+d4xrZVxGMO4KM=
X-Received: by 2002:ac8:598a:0:b0:466:93b9:8356 with SMTP id
 d75a77b69052e-46a4b188f79mr1002427311cf.22.1735945895818; Fri, 03 Jan 2025
 15:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
 <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
In-Reply-To: <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Jan 2025 15:11:25 -0800
Message-ID: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: miklos@szeredi.hu, dhowells@redhat.com, jlayton@kernel.org, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.g=
it
>
> want either no args or 2 args (repo, branch), got 1
>
> > 7a4f5418

Sorry for the late reply on this Miklos, didn't realize this was
related to my "convert direct io to use folios" change.

I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
fuse_get_user_pages on allocation failure") should have fixed this?

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
for-next
