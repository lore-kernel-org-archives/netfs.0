Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BB27A462
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135997; cv=none; b=oUl7dbtn/f3TqtmSB06jFe0cXtezPN0XDY3/hel+7/lupYHs5f/SS6x4n9Di5pJzMINUydBRnaiwDAxTIVSYKPviP18bMVukAuqvXrCddD3uriMJJzJ362SvohSikp3svD/2zr7TSCLSkpZSD6vZC8nt8YDFzMXvKIWVeLFneTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135997; c=relaxed/simple;
	bh=qZtcZTnWxUnymv6cAIxmqQfBFbRdLOm34vdUr0A1Em8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+TP9VjlDUDLWNmPe7BniVSfQch86uEHFPJzi1Vga3mZmh6+v0XDmkz/YHLV0q4tEdhfkIJzTkZTxdNFgeUoQYQKyb5wEhwIqlg62lSRd2S8ijBc7hoL8JkKxs+8/62rBpds+OHnIJITmP9FepK+LI7+eYuIPnZK0ZJhcVpgx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UVkkBoTk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UVkkBoTk"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f7bcde405so156117a12.2
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758135994; x=1758740794; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjAKk6dDrc+RS53N4L4L2Jhabpo688uVi5jmIwo6nKw=;
        b=UVkkBoTkDIlu2D8bjoUl5R7/4TerKWzvhCGl3RBN8ofhCd1CL2Gq7d5oOWmY2UJ8lJ
         af1+/21kKlIB4pQQwSyU7tauN3Ytjd+4Uk3lgy7np/aF9do1lYCZv7GmtyL9yp2u3nnm
         f9tI+GxOD6WZqX5EVEGVHwN0npNaOEoVnYM9DGajqOLcKfkw5jBbvjQoaw2/DB5bPs+i
         /eO2jOSsD8TVhgEeyIp6FjGy29xfOf4pOhCOATclA6Mc7JMnS3xbubutGKmfC1F/0COK
         KU3SqsQKziqhENo2Z4IjmklG0Yj3cXDnsZhYM15l3AX4kSa84OS2u0C7D/e/Afjp37R0
         nmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758135994; x=1758740794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjAKk6dDrc+RS53N4L4L2Jhabpo688uVi5jmIwo6nKw=;
        b=mzw7c1ItVgQK+IX4jwcN494iOgbRnWyUNBhq0oBY1naDfCtZZeE8EcRoFuoMTQ/AEm
         H8pWTme7Hka4Gli7ozEjsImsJ3/bHt1DYRRc2UpLdyubTv+7UluD6CriB8idbbl77O2p
         z3BrEvXwAnvjGqP9LdUmXsTcmHW5g6vYt/kiiTnvsOiDpedqtaJZ7kpdBTT2aBIWphY7
         qQMxtpppI9+PHX27KnefE577+n4PDxX1eJfK0VQ9L41gN1TQhcBom7Gn9iQ8Lyhh9Vdv
         BpcOmw4dI0HfpXcw0+lSVKHt6/pxqUKZCrDgbQaoWMa+GCNQBPP9emR/ViIwQW3oFQN4
         tiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXjV+pis0MuN6P135tIWh4HQqURQF2xSYwcUrtu6HzGRxPUBi+RwJ15MYjcPhaQ5o1niurdjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcx+9RgriqE9CYZJKit+QzG7v3U1UTj41G3k555AQpO85cxah0
	o7IQammcHHPqLyDt7rcZiT4+8l6VlQXeW/Qx7XQhpoJoou9pB2wmklWd5qaznLF8fny8huB6BbW
	OZidctSOWY4RXwJoIWoHr4er1T+vKoqMN4iTn5a4O4Q==
X-Gm-Gg: ASbGnctb5tjKCUAZxrzJEiIEg3GLNPreZZilPZ8zxpuEanlPTxZqN2GV+V8gBsQy56H
	0zoVsV5UUSz2Acn4a6WGbDpkmJ6XpHnQxaaI8rU2Q6taH0iLNXpxg2b73LloecIYU3euDR6hORz
	3JJOkB88sTbGLLQO/WI1imgqit0mEpuSuTdwvEHW5GhU296HjNFdp7qJq3Y4y9MHXawAzJxmpN4
	C7K10z4EXxbnpuUnbe7iMJ97E2/FFyfGg0s0pSVMexV4kU=
X-Google-Smtp-Source: AGHT+IEeoKIGF0DJUkr9LeE+86k79ccZaCCG4KjCllo1uxTbF5z8DSBt0gp58w9mSuOWqhXnNBwuDlyHfOioj70SCBs=
X-Received: by 2002:a17:907:969e:b0:b04:85f2:d26f with SMTP id
 a640c23a62f3a-b1bb73a737bmr455871666b.25.1758135993911; Wed, 17 Sep 2025
 12:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
In-Reply-To: <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 21:06:22 +0200
X-Gm-Features: AS18NWAgiPxioh1hBxBItSQjz6PB8OC4EFRxWlPBDaP02Mv4xKOQfrE0EdtFsAM
Message-ID: <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, "netfs@lists.linux.dev" <netfs@lists.linux.dev>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mjguzik@gmail.com" <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:55=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > +     doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
>
> What's about this?
>
> struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
>
> doutc(fsc, "%p %llx.%llx\n", inode, ceph_vinop(inode));

That means I have to declare this variable at the beginning of the
function because the kernel unfortunately still doesn't allow C99
rules (declare variables where they are used). And that means paying
the overhead for chasing 3 layers of pointers for all callers, even
those 99.99% who return early. Or declare the variable but initialize
it later in an extra line. Is that the preferred coding style?

> > +     WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> > +                              &ceph_inode(inode)->i_work));
>
> This function looks like ceph_queue_inode_work() [1]. Can we use
> ceph_queue_inode_work()?

No, we can not, because that function adds an inode reference (instead
of donating the existing reference) and there's no way we can safely
get rid of it (even if we would accept paying the overhead of two
extra atomic operations).

> Do you imply "if i_work were already"?

Yes, it's a typo.
