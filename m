Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DB207E17
	for <netfs@lists.linux.dev>; Fri,  6 Dec 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497872; cv=none; b=h4odOvU8yNK8ch2uaT/VYMbGfBDbOAX/6mpS5W2AWJK/ibbS8Vp5so76Dix5FSvyVfpvuTGHPXsWeDff53JwwezjPlUvDoDNsVlsvVxQ+l2CMFFUpVmGXOWmbh+buvPAbK32QZLg5MG0ZRVMCcvWvJEMGcOV56iTUcbDkBxFgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497872; c=relaxed/simple;
	bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s0ZlX/2rofokKs4RZ1T45hB97woDs1ZTQsm0Wq/2tP32hnNtB0PrXUZjrrxRetqzk2r0vm+J/aDGdB0lzHUogw5EGLsHhN2uzcSEMwZkZwEa590SYr6Uy5wncJY00Sw3r7FFaAohc3+x1+XVpKNn91IcqbEvlnRVJHUeo3AXbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Yy87Liw2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Yy87Liw2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so2331611fa.1
        for <netfs@lists.linux.dev>; Fri, 06 Dec 2024 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733497869; x=1734102669; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=Yy87Liw28W57BJrAJJPGoZsvzBZmy8tw+FNiGC4Iuuzu0j68ZOKIEV59S7/UveHjJa
         ZM65XMXLNNQMq1oZOQCxGrEqr7EWrOH7NS8bNmrlFagNQJfElF0TbU5qgEfAqOyonvNb
         Y/8ipnREz0Fw41q9zh2YeH08ac0gfykHDv4MNUfxzbovT2/VuMZ/wMt1mpEWJ+6RYXLH
         BbPRfddUNHek/EdLfrjiWbh3N//TWU+U9zFU1kUWn+MpYsotdQ7G0wProloSHKhGIiXm
         LSjxJDrDGFfAbsGrSrWaRGJrIUVU+r8A+7CZnj98OowGP9a4o/0s0LOHdkgdhNKsQbEl
         5Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497869; x=1734102669;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=inmRX/NOKfqOzN45fYjzOT79uXZ9IxZLEzsmodhVceL1LzgYAt2wXVExv+8hVnlYsB
         S5Bok/FLBqZOpFEuKBXL4e5GFd3OytAIVFwktV5/DsQoKuj765ALT0unjD/sD4ifCt9Q
         C+8ZRajBwj42zLxg+/yeopqQi6CAvWtQQFWKGIWtRt2iW06tQ/8etNAGadqoobzcnoLF
         MrrxYQaarzDdsBCw6UAufB1X7UfzDcMzSSqZrDg91VDwiyQodry0zyMaZ+Pc7ZJJoW5p
         c8lKniaidRT9vrma4qBxgQGjiD8mc/Wt959RqtND4eadCqQeznGlVT3DOcuQ+JTIckHU
         /f/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHMLR0lY8cWs+kGKxDG2BMKQKPHlHXtcm2A6Bo28gJ8jtaf9oJ87cYptaJFrzzmmCKrB6uUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZZx4sDH/0L9deWQaRuVCSmWA7u4QmlCJVssjCkIIrNGk10iXs
	wjwAbIi7xLm/wAjhEzIRJ/LJVfnprg+oWcJZzE/K6GyrhN+UMt0sWvwYVeG2qmU4leCbfQcA318
	2LYAtpispXmp+3oiF1vjsvB73tuaviPgY1jYavQ==
X-Gm-Gg: ASbGncuHJTGxiUVoNMtjU3WnW+Hb8AhaV0GY791p7WtMKGAAESm17kp9T/wBqKkZ1cf
	J+F66vOuvVdrOUFzFJ3thCov4eXFRxN1N5x6Qqnhxgtsb1h9aJbUvVwMcRDKp
X-Google-Smtp-Source: AGHT+IHZh7+eSZRrew9jvjXLeL7+e+dVGeI+ATK6u5Qf2A9dzVb3ztmytV9rXvATxrVvHBhLv+Y0gapnch4CBZ6EiOc=
X-Received: by 2002:a2e:bc23:0:b0:2fb:45cf:5eef with SMTP id
 38308e7fff4ca-3002f933d39mr19247661fa.30.1733497867875; Fri, 06 Dec 2024
 07:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
 <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com> <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
In-Reply-To: <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 16:10:57 +0100
Message-ID: <CAKPOu+9v=4qSuESQ5bc94qM=U6OEv3FXZ2gdr3z0MyD5YTRtEA@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:39=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> It has been two weeks since my crash bug report. Our servers are still
> crashing all the time, and instead of going back to 6.6, I have
> enabled `panic_on_oops` so the servers reboot automatically, hoping
> that you would come up with a fix for the netfs regression soon, but I
> cannot hold this up for much longer. Please help!

Nearly 6 weeks now. Currently on 6.11.10, and still many kernel
crashes every day with NFS.
