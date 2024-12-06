Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB679D2
	for <netfs@lists.linux.dev>; Fri,  6 Dec 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494027; cv=none; b=JyW8QIySTWDOYm3Qt9K5ijYY9CyhQzb68Ii/apVdIhGb+QtTwbtnRp//xfGmVCji6K3y9aJ0ZWEGhxaw59/bW+OIVzTUfKbbLgYFIjytkCf7J/v3uORAlQ5piZuXInBqLJ7VdqAXZ3GGU1EhLJNYpLtnCN5m0KJFT8uYuw5PYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494027; c=relaxed/simple;
	bh=Y3jRSyLqGJJ4m0znm8th/SKmR9vjy9aqGsQ2/0KyxGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unjDggFYVHh2uuTYiLE12+Vq4+iLiL67IOTbB5aBjz4kX6CWapL+BVvNPTCcHdBngCAIgdyyhaCK8pfMXvwAyNmwRE7ftJlZTlHJHQuaklmRtXxyZo+aciJcpXmeaz16HHsaIBdLAWQzt9f08ppVJlhK03AH0MKG+5WxfHHvWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AkjK72Re; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AkjK72Re"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso262352066b.1
        for <netfs@lists.linux.dev>; Fri, 06 Dec 2024 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733494022; x=1734098822; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/53FjXdidLh3jZZz1rPsx2rl/+JDtT/CVnYyzJvL7c=;
        b=AkjK72RecDEZtMIA1Jq0IzFTPKuenCR6Fgga3MuEspNzwJo+kb3s/hJCu5N6o6uaJV
         WtEDEjPe7+TWK+d4KD3ZReNFpX6oSTQdqul6MdXQhhVArjMvbahMEtmhctbi4MeXRk9b
         IlZnjxbhwnXmIwh1HgEbDjRyyngJuMx4hvj3G+APc0fUyWJx3YatdDgL91IohT3zqXgF
         RGgvt/aJCIdt833w82OuTW08GD8UyiIlbBOWLV41CNgansl2cMrgMG+dNqn5YHHG5tzR
         9/fEs8s/hsOCLEuCBo+o5Pq4+C59/LR6wwdCeQnoB4KnLb07sWJhBaIyHZYJvi+Y2VTu
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494022; x=1734098822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/53FjXdidLh3jZZz1rPsx2rl/+JDtT/CVnYyzJvL7c=;
        b=H/bV4WLS85yM510YsMFtetvT8py+UqF9nVvPzd/lAG9Wx+KajCOO9aIY+oVmB+1YhC
         SPHMmLoeoOtjop3FeZpRK1uFSVK7Wzf7UdbuMxR7Tx6fbdIdrgEPnCzYo7lOmiQvcEep
         kblKB1zmemTh2q3S+lhawjlg0KyXO2vCcx97PQdNlCuljNnQ9fD+6V2y4CwdfHeziCmN
         c8WiRF1IzIhOvkiQw7jkOQ+rZMfSoVZ2vmIZul6otZytji/Q49yXG2TD7enNFmrkVb2w
         ncgXVhZ5VJKXhQRpH+vnUuI/4HXISNcAzWRiHUc2Tal2yY/nPLEcgSfDLx7qbjQJ7kOt
         Zs8Q==
X-Gm-Message-State: AOJu0YwVgArLepE5hFHGVLvQXXxlqPdq2N1MbHFjPRnt29sSv3MaqZlX
	vEjEibi6pmgGf66gmyw97L5MOdc3aQlpTfKjPzYVwaW9a5/xpSBLVI5FztBCF9m7O0ifVy4o46k
	i+ZuCHEWchzf+WCNgcDkZ6rot1bIFdluUE/OVfscWX49sVb8JU8m0Vg==
X-Gm-Gg: ASbGncuUvBFoQxjSkUKDT05YvvBExJYcsPg5Vm2X5rWrl0QlbLPUEmIvvl6ZIsqj6YQ
	5LiG3+HTWdMkA7M+ULx5OiPyx8/2yZ07Ydnf33iAjO2sKqaGVEvBxbmjuZljE
X-Google-Smtp-Source: AGHT+IHusLFPrUcP5Q+1cLknHTOnkJQnFc/dkEmQ8NKaIbWLWU6reloS6YJa6ES2YA1j6z5hweoJjDWdDUAcTA5wUx0=
X-Received: by 2002:a17:907:a192:b0:aa6:c55:7397 with SMTP id
 a640c23a62f3a-aa63a21c376mr264845866b.45.1733494022312; Fri, 06 Dec 2024
 06:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
 <4022108.1732899245@warthog.procyon.org.uk>
In-Reply-To: <4022108.1732899245@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 15:06:50 +0100
Message-ID: <CAKPOu+_gzJCN6OKYvUw+H9kDrc3YG8yxJS_YDx41zS==wBKpbA@mail.gmail.com>
Subject: Re: New cachefilesd implementation
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:54=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Now, would you be able to clone this:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachefil=
esd.git/
>
> Then rip out the existing code and put in your code?  There's some stuff =
in
> there that is necessary to run on SELinux-based systems and it would make=
 it
> a lot easier for me just to replace the current cachefilesd package by ju=
st
> pulling yours directly.

Here:

https://github.com/CM4all/cash/tree/cachefilesd2

Please check if that's how you envisioned it. License is also changed
to BSD2 or GPL2+.
RFC! - it's not yet finalized, and not yet ready for merging.

Meanwhile, I have implemented lots of further optimizations. Now
almost all I/O (except for readdir()) is done with io_uring -
including writes to /dev/cachefiles, which required some tricky
machinery around fchdir(), because /dev/cachefiles accepts only file
names in the current working directory.

Some things are missing completely, like logging and daemonization. I
believe that daemonization is an obsolete feature and the init system
should take care for daemonization.

This implementation has been running on our production servers for
more than a week now and the problems we had with the old cachefilesd
are gone now. It's as fast as it can be, thanks to io_uring, and is
more secure: it drops CAP_SYS_ADMIN after opening /dev/cachefiles, and
has no other capabilities.

Max
